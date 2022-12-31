import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:prajwol/add_product_controller.dart';
import 'package:prajwol/isAdmin.dart';
import 'product_display.dart';

class catalogue extends StatefulWidget {
  @override
  State<catalogue> createState() => _catalogueState();
}

class _catalogueState extends State<catalogue> with TickerProviderStateMixin {
  final userToken = FirebaseAuth.instance.currentUser?.uid;
  final addProductController a = Get.put(addProductController());
  final Stream<QuerySnapshot> cycle =
      FirebaseFirestore.instance.collection('Cycle').snapshots();
  final Stream<QuerySnapshot> Budho =
      FirebaseFirestore.instance.collection('Budho').snapshots();
  final Stream<QuerySnapshot> sports =
      FirebaseFirestore.instance.collection('sports').snapshots();

  void deletecycle(id) {
    FirebaseFirestore.instance.collection('Cycle').doc(id).delete();
    print("deleted");
  }

  void deletebudho(id) {
    FirebaseFirestore.instance.collection('Budho').doc(id).delete();
    print("deleted");
  }

  void deletesports(id) {
    FirebaseFirestore.instance.collection('sports').doc(id).delete();
    print("deleted");
  }

  @override
  Widget build(BuildContext context) {
    TabController catalogueTab = TabController(length: 3, vsync: this);
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "Hot",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                    child: Text(
                  "sports",
                  style: TextStyle(color: Colors.black),
                )),
                Tab(
                    child: Text(
                  "Budho",
                  style: TextStyle(color: Colors.black),
                ))
              ],
              controller: catalogueTab,
              isScrollable: true,
              labelPadding: EdgeInsets.symmetric(horizontal: 30),
            ),
          ),
          Expanded(
              child: TabBarView(
            controller: catalogueTab,
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: cycle,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      Get.defaultDialog(title: "error");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final data = snapshot.requireData;
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 400,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20),
                        itemCount: data.size,
                        itemBuilder: ((context, index) {
                          final String img = data.docs[index]['image'];
                          final String name = data.docs[index]['name'];
                          final int price = data.docs[index]['price'];
                          final String desc = data.docs[index]['Description'];
                          // print(img);
                          return InkWell(
                            onTap: () => Get.to(productDisplay(),
                                arguments: [name, img, price, desc]),
                            child: SizedBox(
                              // height: 700,
                              // width: 500,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.network(
                                    img,
                                    height: 200,
                                    width: 300,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(name),
                                  Text(price.toString()),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            a.addProduct(img, name, 1, price);
                                            Get.snackbar("product added",
                                                "please Check your cart");
                                          },
                                          child: Text("Add to cart")),
                                      if (isAdmin(userToken))
                                        ElevatedButton(
                                          child: Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () {
                                            deletecycle(data.docs[index].id);
                                          },
                                        )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            ),
                          );
                        }));
                  }),
              StreamBuilder<QuerySnapshot>(
                  stream: sports,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      Get.defaultDialog(title: "error");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final data1 = snapshot.requireData;
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 400,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20),
                        itemCount: data1.size,
                        itemBuilder: ((context, indexi) {
                          final String img1 = data1.docs[indexi]['image'];
                          final String name1 = data1.docs[indexi]['name'];
                          final int price1 = data1.docs[indexi]['price'];
                          final String Desc1 =
                              data1.docs[indexi]['Description'];
                          // print(img);
                          return InkWell(
                            onTap: () => Get.to(productDisplay(),
                                arguments: [name1, img1, price1, Desc1]),
                            child: SizedBox(
                              // height: 700,
                              // width: 500,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.network(
                                    img1,
                                    height: 200,
                                    width: 300,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(name1),
                                  Text(price1.toString()),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            a.addProduct(
                                                img1, name1, 1, price1);
                                            Get.snackbar("product added",
                                                "please Check your cart");
                                          },
                                          child: Text("Add to cart")),
                                      if (isAdmin(userToken))
                                        ElevatedButton(
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            deletesports(data1.docs[indexi].id);
                                          },
                                        )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            ),
                          );
                        }));
                  }),
              StreamBuilder<QuerySnapshot>(
                  stream: Budho,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      Get.defaultDialog(title: "error");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final data2 = snapshot.requireData;
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 400,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20),
                        itemCount: data2.size,
                        itemBuilder: ((context, index) {
                          final String img2 = data2.docs[index]['image'];

                          final String name2 = data2.docs[index]['name'];
                          final int price2 = data2.docs[index]['price'];
                          final String Desc2 = data2.docs[index]['Description'];
                          // print(img);
                          return InkWell(
                            onTap: () => Get.to(productDisplay(),
                                arguments: [name2, img2, price2, Desc2]),
                            child: SizedBox(
                              // height: 700,
                              // width: 500,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.network(
                                    img2,
                                    height: 200,
                                    width: 300,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(name2),
                                  Text(price2.toString()),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            a.addProduct(
                                                img2, name2, 1, price2);
                                            Get.snackbar("product added",
                                                "please Check your cart");
                                          },
                                          child: Text("Add to cart")),
                                      if (isAdmin(userToken))
                                        ElevatedButton(
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            deletebudho(data2.docs[index].id);
                                          },
                                        )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            ),
                          );
                        }));
                  }),
            ],
          ))
        ],
      ),
    )
        // bottom: TabBar(
        //   tabs: [
        //     Tab(
        //       text: "Recent",
        //     ),
        //     Tab(
        //       text: "MTB",
        //     ),
        //     Tab(
        //       text: "Budo",
        //     ),
        //     Tab(
        //       text: "electric",
        //     )
        //   ],
        // ),
        );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prajwol/Btn.dart';
import 'package:prajwol/checkout_screen.dart';
import 'package:prajwol/paymentSuccess.dart';
import 'package:prajwol/product_display.dart';
import 'Cart_controller.dart';

class products {
  String? image;
  String? name;
  int? price;

  products(String image, String name, int price) {
    this.image = image;
    this.name = name;
    this.price = price;
  }
}

class cart extends StatefulWidget {
  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  void initState() {
    super.initState();
    setState(() {
      amount = 0;
    });
    products = [];
  }

  @override
  final Cart_controller c = Get.put(Cart_controller());

  final Stream<QuerySnapshot> cartdb = FirebaseFirestore.instance
      .collection('cart')
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
      .snapshots();
  late List<List<dynamic>> products;
  late double amount = 0.0;
  Map<String, dynamic>? paymentIntent;
  Future<double> calculateTotalPrice() async {
    double totalPrice = 0;
    var querySnapshot =
        await FirebaseFirestore.instance.collection('cart').get();
    querySnapshot.docs.forEach((element) {
      totalPrice += element.data()['price'];
    });
    setState(() {
      amount = totalPrice;
    });
    return totalPrice;
    print(products);
  }

  void navigateToCheckoutScreen() {
    calculateTotalPrice().then((totalPrice) {
      Get.to(checkout_screen(), arguments: [totalPrice, products]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Image.network(
                "https://mir-s3-cdn-cf.behance.net/projects/404/5ae33f146852067.Y3JvcCw4MDgsNjMyLDE4Miww.jpg"),
            height: 150,
            width: 100,
          ),
          SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 400,
              child: StreamBuilder<QuerySnapshot>(
                  stream: cartdb,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      Get.defaultDialog(title: "error");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final cartData = snapshot.requireData;

                    return ListView.builder(
                        itemCount: cartData.size,
                        itemBuilder: (BuildContext context, int index) {
                          products = List.generate(
                              cartData.size, (index) => List.filled(3, 0),
                              growable: false);
                          final String img = cartData.docs[index]['image'];
                          final String name = cartData.docs[index]['name'];
                          final int price = cartData.docs[index]['price'];
                          products[index][0] = img;
                          products[index][1] = name;
                          products[index][2] = price;

                          return Container(
                            margin: EdgeInsets.fromLTRB(5.0, 5.0, 15.0, 15.0),
                            width: MediaQuery.of(context).size.width - 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.network(
                                  img,
                                  height: 40,
                                  width: 40,
                                ),
                                Container(
                                  width: 72,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(name),
                                      Text("star : 5 star"),
                                      Text(price.toString())
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: (() =>
                                      delete(cartData.docs[index].id)),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  }),
            ),
          ),
          Container(
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                  onPressed: () {
                    // navigateToCheckoutScreen();
                    addOrder(products);
                  },
                  child: Text("Checkout")),
            ),
          )
        ],
      ),
    ));
  }

  void delete(id) {
    FirebaseFirestore.instance.collection('cart').doc(id).delete();
    print("deleted");
  }

  Future<void> makepayment() async {
    try {} catch (e) {
      print(e);
    }
  }
}

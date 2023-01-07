import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prajwol/Btn.dart';
import 'package:prajwol/checkout_screen.dart';
import 'package:prajwol/product_display.dart';
import 'Cart_controller.dart';

class cart extends StatelessWidget {
  @override
  final Cart_controller c = Get.put(Cart_controller());
  final Stream<QuerySnapshot> cartdb = FirebaseFirestore.instance
      .collection('cart')
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
      .snapshots();

  int amount = 0;
  List newprice = <int>[];
  var a;
  var passamt;

  sum() {
    newprice.clear();
    passamt = 0;
    a = 0;
    amount = 0;
    FirebaseFirestore.instance.collection('cart').get().then((value) => {
          value.docs.forEach((element) {
            a = element.data()['price'];

            newprice.add(a);
            for (int b in newprice) {
              amount = amount + b;
            }
            passamt = amount - newprice[0];
            Get.to(checkout_screen(), arguments: [passamt]);
            passamt = 0;
            newprice.clear();
            a = 0;
            amount = 0;
          })
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
                          final String img = cartData.docs[index]['image'];
                          final String name = cartData.docs[index]['name'];
                          final int price = cartData.docs[index]['price'];

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
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Total amount : ${amount}"),
                  TextButton(
                      onPressed: () {
                        sum();
                      },
                      child: Text("Checkout"))
                ],
              ),
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

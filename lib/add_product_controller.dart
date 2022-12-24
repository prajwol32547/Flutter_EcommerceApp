import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';

class addProductController extends GetxController {
  final UID = FirebaseAuth.instance.currentUser?.uid;

  void addProduct(String cartimg, String cartname, int cartqty, int cartprice) {
    Map<String, dynamic> cartdata = {
      "image": cartimg,
      "name": cartname,
      "price": cartprice,
      "quantity": cartqty,
      "uid": UID
    };
    FirebaseFirestore.instance.collection('cart').add(cartdata);
  }
}

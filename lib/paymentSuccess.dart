import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final UID = FirebaseAuth.instance.currentUser?.uid;

void addOrder(List<List<dynamic>> order) async {
  int i = 0;
  order.forEach((innerList) {
    innerList.forEach((element) {
      Map<String, dynamic> orderList;
      orderList = {
        'image': element[0].toString(),
        'name': element[1].toString(),
        'price': element[2].toString()
      };
      FirebaseFirestore.instance.collection('Orders').add(orderList);
    });
    i++;
  });
}

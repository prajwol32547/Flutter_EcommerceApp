import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class orderStatus extends StatefulWidget {
  @override
  State<orderStatus> createState() => orderStatusState();
}

class orderStatusState extends State<orderStatus> {
  @override
  final Stream<QuerySnapshot> cycle =
      FirebaseFirestore.instance.collection('Orders').snapshots();
  Widget build(BuildContext context) {
    return Container();
  }
}

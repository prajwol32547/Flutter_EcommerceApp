import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class Cart_controller extends GetxController {
  RxInt count = 0.obs;

  void increase() {
    count++;
  }

  void decrement() {
    if (count > 0) {
      count--;
    }
  }
}

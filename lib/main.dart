import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:prajwol/uploadProduct.dart';
import 'catalogue.dart';
import 'home.dart';
import 'Login.dart';
import 'product_display.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51MQDM6KWlepehOjh7yoIAkQH2sUMds7oWzbIVlQ7ACISqdDnA33ukRRkj0geQGzDmmOUFDnTxrFoKpKX3QIMJZzF00xQpRZHM2";
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      getPages: [
        GetPage(name: "/home", page: () => Home()),
        GetPage(name: "/catalogue", page: () => catalogue()),
        GetPage(name: "/product_display", page: () => productDisplay()),
        GetPage(name: "/Login", page: () => Login()),
        GetPage(name: "/uploadProduct", page: () => uploadProduct())
      ]));
}

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
      "pk_test_51MA2VISAQSa9VQdPudybn7v1lAguuXCufoKlXl9wtZvc2NEgwtZzc3mdrxjvrxpiswZvlfMG6NaHXvoQI4d60iQv00KRtSgvTt";
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

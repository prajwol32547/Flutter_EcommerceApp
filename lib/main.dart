import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:prajwol/uploadProduct.dart';
import 'catalogue.dart';
import 'home.dart';
import 'Login.dart';
import 'product_display.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

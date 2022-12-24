import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prajwol/Login.dart';
import 'package:prajwol/bottom_navigation_controller.dart';
import 'package:prajwol/cart.dart';
import 'package:prajwol/catalogue.dart';
import 'package:prajwol/firstPage.dart';
import 'package:prajwol/userProfile.dart';

class Home extends StatelessWidget {
  @override
  bottomNavigationController BNC = Get.put(bottomNavigationController());
  final screens = [
    firstpage(),
    catalogue(),
    cart(),
    Userprofile(),
  ];
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(scrollDirection: Axis.vertical, children: [
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("More info"),
              onTap: () {
                showAboutDialog(
                    context: context,
                    applicationName: "cyclemandu",
                    applicationVersion: "1.0");
              },
            ),
            ListTile(
                leading: Icon(Icons.logout),
                title: Text("logout"),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  FirebaseAuth.instance.authStateChanges();
                  Get.offAll(() => Login());
                }),
            ListTile(
              leading: Icon(Icons.toggle_off),
              title: Text("change theme"),
              onTap: () => Get.changeTheme(
                  Get.isDarkMode ? ThemeData.light() : ThemeData.dark()),
            )
          ]),
        ),
        appBar: AppBar(
          primary: false,
          automaticallyImplyLeading: true,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              "https://mir-s3-cdn-cf.behance.net/projects/404/5ae33f146852067.Y3JvcCw4MDgsNjMyLDE4Miww.jpg",
              height: 70,
              width: 70,
            ),
          ),
          actions: [
            Icon(Icons.notifications),
            SizedBox(
              width: 20,
            ),
            Icon(Icons.shopping_cart),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Obx(() => IndexedStack(
              index: BNC.selectedIndex.value,
              children: screens,
            )),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  BNC.changeIndex(index);
                },
                currentIndex: BNC.selectedIndex.value,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.business), label: "catalogue"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart), label: "cart"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "profile")
                ])),
      ),
    );
  }
}

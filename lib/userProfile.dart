import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prajwol/User_form.dart';
import 'package:prajwol/product_display.dart';
import 'package:prajwol/userListModel.dart';

class Userprofile extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser?.uid;
  final Dname = FirebaseAuth.instance.currentUser?.displayName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            title: Dname != null ? Text(Dname!) : Text("Null"),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
              child: Wrap(
            runSpacing: 20,
            children: [
              userListModel(
                  "Edit profile", Icons.person, () => Get.to(user_form())),
              userListModel("My orders", Icons.shop, () {
                try {
                  Get.to(productDisplay());
                } on Exception catch (_, e) {
                  printError();
                }
              }),
              userListModel("payments history", Icons.settings,
                  () => Get.to(productDisplay())),
              // userListModel("Upload Product", Icons.add_shopping_cart_rounded,
              //     () => Get.toNamed("/uploadProduct")),
              userListModel("Edit profile", Icons.settings,
                  () => Get.to(productDisplay()))
            ],
          )),
        )
      ],
    )));
  }
}

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
            title: Text(Dname!),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
              child: Wrap(
            runSpacing: 20,
            children: [
              userListModel(
                  "Edit profile", Icons.person, () => Get.to(user_form())),
              userListModel(
                  "My orders", Icons.shop, () => Get.to(productDisplay())),
              userListModel("payments history", Icons.settings,
                  () => Get.to(productDisplay())),
              userListModel("", Icons.settings, () => Get.to(productDisplay())),
              userListModel("Edit profile", Icons.settings,
                  () => Get.to(productDisplay()))
            ],
          )),
        )
      ],
    )));
  }
}

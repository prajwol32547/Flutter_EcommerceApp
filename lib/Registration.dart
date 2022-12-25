import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prajwol/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Field.dart';

class Registration extends StatelessWidget {
  @override
  final emailRegister_controller = TextEditingController();
  final passwordRegister_controller = TextEditingController();
  final Displayname_controller = TextEditingController();
  final PhoneNumber_controller = TextEditingController();
  Future signup() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailRegister_controller.text.trim(),
              password: passwordRegister_controller.text.trim())
          .then((value) {
        return FirebaseAuth.instance.currentUser
            ?.updateDisplayName(Displayname_controller.text.trim());
      });
      Get.toNamed("/Login");
    } catch (exception) {
      Get.defaultDialog(content: Text("Some error occured while registering"));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              child: Image.network(
                  "https://mir-s3-cdn-cf.behance.net/projects/404/5ae33f146852067.Y3JvcCw4MDgsNjMyLDE4Miww.jpg",
                  height: MediaQuery.of(context).size.width,
                  width: 300),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Field(emailRegister_controller, context, "Email"),
                  SizedBox(
                    height: 30,
                  ),
                  Field(passwordRegister_controller, context, "Password"),
                  SizedBox(
                    height: 30,
                  ),
                  Field(Displayname_controller, context, "Display Name"),
                  SizedBox(
                    height: 30,
                  ),
                  Field(PhoneNumber_controller, context, "phone Number"),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 30,
                    child: ElevatedButton(
                      onPressed: signup,
                      child: Text("Register"),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(children: [
                          Text("Already Registered ?"),
                          GestureDetector(
                            onTap: () {
                              Get.to(Login());
                            },
                            child: Text("sign in"),
                          )
                        ])),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    ));
  }
}

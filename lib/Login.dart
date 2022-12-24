import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prajwol/Registration.dart';
import 'package:prajwol/home.dart';

import 'Field.dart';

class Login extends StatelessWidget {
  @override
  final e_controller = TextEditingController();
  final p_controller = TextEditingController();

  Future signIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: e_controller.text.trim(),
              password: p_controller.text.trim())
          .then((value) => Get.to(Home()));
      print(FirebaseAuth.instance.currentUser?.email);
      FirebaseAuth.instance.authStateChanges();
    } catch (exception) {
      Get.defaultDialog(content: Text("wrong credentials"));
    }
  }

  @override
  void dispose() {
    e_controller.dispose();
    p_controller.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Image.network(
                      "https://mir-s3-cdn-cf.behance.net/projects/404/5ae33f146852067.Y3JvcCw4MDgsNjMyLDE4Miww.jpg",
                      height: MediaQuery.of(context).size.width,
                      width: 300,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Field(e_controller, context, "Email"),
                        SizedBox(
                          height: 30,
                        ),
                        Field(p_controller, context, "Password"),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 30,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: signIn,
                            // onPressed: () {
                            //   if (e_controller.text == "prajwol" &&
                            //       p_controller.text == "lama") {
                            //     Get.to(() => Home());
                            //   } else {
                            //     Get.defaultDialog(
                            //         title: "error", content: Text("please try again"));
                            //   }
                            // },
                            child: Text("login"),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(children: [
                              Text("Not Registered Yet?"),
                              GestureDetector(
                                onTap: () => Get.to(Registration()),
                                child: Text("signup"),
                              )
                            ])),
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    ));
  }
}

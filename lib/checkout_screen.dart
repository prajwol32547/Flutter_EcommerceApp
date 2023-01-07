import 'package:flutter/material.dart';
import 'package:get/get.dart';

class checkout_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var amt = Get.arguments;
    print(amt);
    return Container(
      child: Center(
          child: ElevatedButton(
        onPressed: () {},
        child: Text("checkout ${amt[0]}"),
      )),
    );
  }
}

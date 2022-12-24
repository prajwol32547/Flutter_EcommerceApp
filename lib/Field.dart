import 'package:flutter/material.dart';

Widget Field(controller, context, hintText) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: TextField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
    ),
  );
}

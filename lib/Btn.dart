import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

Widget Btn(func, IconData) {
  return SizedBox(
      width: 40,
      child: ElevatedButton(
        onPressed: func,
        child: Icon(IconData),
      ));
}

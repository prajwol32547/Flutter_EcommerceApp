import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget userListModel(String title, IconData icon, func) {
  return ListTile(
    minVerticalPadding: 10,
    tileColor: Color.fromARGB(255, 219, 217, 217),
    leading: Icon(icon),
    title: Text(title),
    onTap: func,
  );
}

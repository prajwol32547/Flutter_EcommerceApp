import 'package:flutter/material.dart';

Widget buildCategory1Tile({required String titleName, required String img}) {
  return SizedBox(
    width: 150,
    child: Container(
      margin: EdgeInsets.all(8.0),
      // decoration: new BoxDecoration(color: Colors.pink),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Image.network(
          img,
          height: 100,
          width: 100,
        ),
        Text(titleName),
      ]),
    ),
  );
}

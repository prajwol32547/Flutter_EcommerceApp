import 'package:flutter/material.dart';

import 'categorymodel.dart';

Widget categoryFirst(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Column(children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Category",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black),
            ),
            Text(
              "view all",
              style: TextStyle(color: Color.fromRGBO(76, 64, 155, 1)),
            )
          ],
        ),
      ),
      SizedBox(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildCategory1Tile(
                      titleName: "Bank management",
                      img:
                          "https://risingnepaldaily.com/storage/media/5875/bank.jpg"),
                  buildCategory1Tile(
                      titleName: "Fadey Airlines",
                      img:
                          "https://www.airlines.org/wp-content/uploads/2020/10/HeaderImage-1.png"),
                  buildCategory1Tile(
                      titleName: "Bank management",
                      img:
                          "https://risingnepaldaily.com/storage/media/5875/bank.jpg"),
                  buildCategory1Tile(
                      titleName: "Fadey Airlines",
                      img:
                          "https://www.airlines.org/wp-content/uploads/2020/10/HeaderImage-1.png")
                ],
              ),
            )
          ],
        ),
      )
    ]),
  );
}

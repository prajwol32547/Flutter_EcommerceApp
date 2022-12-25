import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class productDisplay extends StatelessWidget {
  // String image = "";
  // late int price;
  // productDisplay(String name, int price, String image) {
  //   this.name = name;
  //   this.price = price;
  //   this.image = image;
  // }
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 600,
            pinned: true,
            flexibleSpace: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FlexibleSpaceBar(
                  background: data == null
                      ? Image.network(
                          "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
                          fit: BoxFit.contain,
                        )
                      : Image.network(data![1])),
            ),
            // title: data[0] == null ? Text("hy") : Text(data[0]),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: data != null
                        ? Text("name:${data![0]}")
                        : Text("Null value")),
                Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: data != null
                        ? Text("price:${data![2]}")
                        : Text("Null value")),
                Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Text("Ratings:5"))
              ]),
            ),
          )
        ],
      ),
    );
  }
}

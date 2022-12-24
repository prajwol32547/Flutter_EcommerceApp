import 'package:flutter/material.dart';
import 'carouselSlider.dart';
import 'category.dart';

class firstpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NonLoopingDemo(),
            categoryFirst(context),
            categoryFirst(context),
            categoryFirst(context),
          ],
        ),
      ),
    );
  }
}

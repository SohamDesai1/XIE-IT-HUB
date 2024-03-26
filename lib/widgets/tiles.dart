import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Tile extends StatelessWidget {
  final Color color;
  final String image;
  final String name;
  const Tile(
      {super.key,
      required this.color,
      required this.image,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 43.w,
      height: 16.2.h,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5)),
          border: Border.all(color: Colors.black),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4.0,
              offset: Offset(3.0, 0),
            )
          ],
          color: Colors.white),
      child: Column(
        children: [
          Center(
              child: Image.asset(
            image,
            width: 17.w,
            height: 10.h,
          )),
          Text(name),
          SizedBox(
            height: 2.85.h,
          ),
          Container(
            width: 50.w,
            height: 0.7.h,
            color: color,
          )
        ],
      ),
    );
  }
}

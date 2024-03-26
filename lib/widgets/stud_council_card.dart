import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class StudCouncilCard extends StatelessWidget {
  final String image;
  final String name;
  final String position;
  final String year;
  const StudCouncilCard(
      {super.key,
      required this.image,
      required this.name,
      required this.position,
      required this.year});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20)),
      width: 45.w,
      height: 35.h,
      child: Column(
        children: [
          SizedBox(
            height: 3.h,
          ),
          CircleAvatar(
            radius: 20.w,
            backgroundImage: AssetImage(
              image,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            position,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            "$year IT",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

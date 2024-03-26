import 'package:college_manager/widgets/stud_council_card.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class StudentCouncil extends StatefulWidget {
  const StudentCouncil({super.key});

  @override
  State<StudentCouncil> createState() => _StudentCouncilState();
}

class _StudentCouncilState extends State<StudentCouncil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: const Text(
              "Student Committee",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const StudCouncilCard(
              image: "assets/images/dhruv.png",
              name: "Dhruv Agrawal",
              position: "Finance Head",
              year: "BE"),
          SizedBox(
            width: 3.w,
          ),
          const StudCouncilCard(
              image: "assets/images/dhruv.png",
              name: "Dhruv Agrawal",
              position: "Finance Head",
              year: "BE"),
        ],
      ),
    );
  }
}

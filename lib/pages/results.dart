import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Results extends StatefulWidget {
  const Results({super.key});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xC90000FF),
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: const Text(
              "Results",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: SizedBox(
        child: Image.asset("assets/images/results.jpeg"),
      ),
    );
  }
}

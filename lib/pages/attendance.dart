// ignore_for_file: prefer_const_constructors

import 'package:college_manager/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Attendance(),
  ));
}

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final List _subjects = ['GIT', 'WT', 'DMBI', 'AI&DS', 'WEBX'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Attendance")),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.add),
      // ),
      body: Text(""),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

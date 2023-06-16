// ignore_for_file: prefer_const_constructors ,prefer_const_literals_to_create_immutables

import 'package:college_manager/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: Home(),
//   ));
// }

class Home extends StatefulWidget {
  final Widget child;
  const Home({super.key, required this.child});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: widget.child,
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

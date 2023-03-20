// ignore_for_file: unused_import, prefer_const_constructors, prefer_typing_uninitialized_variables
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:college_manager/attendance.dart';
import 'package:college_manager/home.dart';
// import 'package:college_manager/splash.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedindex = 0;

  void _itemTapped(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List pages = [
      Home(),
      Attendance(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("College Manager"),
      ),
      body: pages[_selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _itemTapped,
        currentIndex: _selectedindex,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Attendance",
          ),
        ],
      ),
    );
  }
}

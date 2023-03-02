// ignore_for_file: unused_import, prefer_const_constructors, prefer_typing_uninitialized_variables
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:college_manager/splash.dart';
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
  var day;
  var monday = ['GIT', 'WT', 'DMBI', 'AI&DS', 'BI-LAB'];
  var tuesday = ['WEBX', 'DMBI', 'Mini Project', 'Mini Project', 'MAD-LAB'];
  var wednesday = ['AI&DS', 'WEBX', 'WT', 'GIT', 'SENSOR-LAB'];
  var thursday = ['GIT', 'WT', 'DMBI', 'AI&DS', 'DS-LAB'];
  var friday = ['WEB-LAB', 'WT', 'VAC', 'MENTORY', 'TPO'];

  void _itemTapped(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getDay();
    });
    final List pages = [
      Center(
        child: Text("This is Home page"),
      ),
      Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Center(child: Text(day[index]));
          },
          itemCount: day.length,
        ),
      ),
    ];
    return Scaffold(
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
            label: "Time Table",
          ),
        ],
      ),
    );
  }

  void getDay() {
    var getday = DateTime.now().weekday;
    if (getday == 1) {
      day = monday;
    }
    if (getday == 2) {
      day = tuesday;
    }
    if (getday == 3) {
      day = wednesday;
    }
    if (getday == 4) {
      day = thursday;
    }
    if (getday == 5) {
      day = friday;
    } else {
      day = "CHUTTI HAI!!";
    }
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TimeTable(),
  ));
}

class TimeTable extends StatefulWidget {
  const TimeTable({super.key});

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  var day;
  var monday = ['GIT', 'WT', 'DMBI', 'AI&DS', 'BI-LAB'];
  var tuesday = ['WEBX', 'DMBI', 'Mini Project', 'Mini Project', 'MAD-LAB'];
  var wednesday = ['AI&DS', 'WEBX', 'WT', 'GIT', 'SENSOR-LAB'];
  var thursday = ['GIT', 'WT', 'DMBI', 'AI&DS', 'DS-LAB'];
  var friday = ['WEB-LAB', 'WT', 'VAC', 'MENTORY', 'TPO'];

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
    }
    if (getday == 6 || getday == 7) {
      day = "CHUTTI HAI!!";
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getDay();
    });
    return Scaffold(
      body: Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Center(child: Text(day[index]));
          },
          itemCount: day.length,
        ),
      ),
    );
  }
}

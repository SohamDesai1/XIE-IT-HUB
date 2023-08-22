// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables,prefer_const_literals_to_create_immutables

import 'package:college_manager/widgets/expanded_tt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:college_manager/utils/timeTable.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({super.key});

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  var day;
  var currLec;
  var isEvening = DateTime.now().hour;
  var hour = DateTime.now().hour;

  @override
  void initState() {
    super.initState();
    getDay();
    getCurrentLec();
  }

  void getDay() {
    var getday = DateTime.now().weekday;
    if (getday == 1) {
      day = monday;
    }
    if (getday == 2 || (getday == 1 && isEvening > 16)) {
      day = tuesday;
    }
    if (getday == 3 || (getday == 2 && isEvening > 16)) {
      day = wednesday;
    }
    if (getday == 4 || (getday == 3 && isEvening > 16)) {
      day = thursday;
    }
    if (getday == 5 || (getday == 4 && isEvening > 16)) {
      day = friday;
    }
    if (getday == 6 || getday == 7 || (getday == 5 && isEvening > 16)) {
      day = weekend;
    }
    if ((getday == 7 && isEvening > 16)) {
      day = monday;
    }
  }

  void getCurrentLec() {
    if ((DateTime.now().hour == 8 && DateTime.now().minute >= 45) ||
        (DateTime.now().hour == 9 && DateTime.now().minute < 45)) {
      currLec = day[0];
    }
    if ((DateTime.now().hour == 9 && DateTime.now().minute >= 45) ||
        (DateTime.now().hour == 10 && DateTime.now().minute <= 45)) {
      currLec = day[1];
    }
    if ((DateTime.now().hour == 11 && DateTime.now().minute >= 0) ||
        (DateTime.now().hour == 12 && DateTime.now().minute < 0)) {
      currLec = day[2];
    }
    if ((DateTime.now().hour == 12 && DateTime.now().minute >= 0) ||
        (DateTime.now().hour == 13 && DateTime.now().minute <= 0)) {
      currLec = day[3];
    }
    if ((DateTime.now().hour == 13 && DateTime.now().minute >= 30) ||
        (DateTime.now().hour == 14 && DateTime.now().minute < 30)) {
      currLec = day[4];
    }
    if ((DateTime.now().hour == 14 && DateTime.now().minute >= 30) ||
        (DateTime.now().hour == 15 && DateTime.now().minute < 30)) {
      currLec = day[5];
    }
    if ((DateTime.now().hour == 15 && DateTime.now().minute >= 30) ||
        (DateTime.now().hour == 14 && DateTime.now().minute < 30)) {
      currLec = day[6];
    }
    if (DateTime.now().hour > 15 && DateTime.now().minute >= 30) {
      currLec = "Din Khatam!!";
    }
    if (DateTime.now().hour > 16) {
      currLec = "Din Khatam!!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ExpandedTT())),
      child: Container(
        width: 90.w,
        height: 35.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3),
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 255, 255, 39),
        ),
        child: Column(
          children: [
            isEvening > 16 || isEvening < 8
                ? Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Tommorow's Time Table",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : Container(
                    alignment: Alignment.topCenter,
                    child: Text("Today's Time Table",
                        style: TextStyle(fontSize: 20)),
                  ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 90,
            ),
            Row(
              children: [
                Expanded(
                    child: isEvening > 16 || isEvening < 8
                        ? Text(
                            "${DateFormat.EEEE().format(DateTime.now().add(Duration(days: 1)))}\n${DateFormat.MMMMd().format(DateTime.now().add(Duration(days: 1)))}",
                            style: TextStyle(fontSize: 30),
                          )
                        : Text(
                            "${DateFormat.EEEE().format(DateTime.now())}\n${DateFormat.MMMMd().format(DateTime.now())}",
                            style: TextStyle(fontSize: 30),
                          )),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 10,
                        ),
                        child: Text(
                          day[index],
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    },
                    itemCount: day.length,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            Divider(
              color: Colors.black,
              thickness: 2,
              endIndent: 50,
              indent: 50,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width / 40),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      "Current Lecture:\n$currLec",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 20,
                    ),
                    Text("(Click for expanded view)")
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

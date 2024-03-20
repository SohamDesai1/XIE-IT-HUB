import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TTCard extends StatelessWidget {
  const TTCard(
      {super.key,
      required this.classRoom,
      required this.subject,
      required this.time,
      required this.status});
  final String subject;
  final String time;
  final String classRoom;
  final String status;

  Color determineColor() {
    if (status == "Ongoing") {
      return Colors.red;
    } else if (status == "Next lecture") {
      return Colors.orangeAccent;
    } else if (status == "done") {
      return Colors.blueAccent;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 36.w,
        height: 8.5.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black),
            color: Colors.grey[170]),
        child: Padding(
          padding: EdgeInsets.only(top: 2.w),
          child: Padding(
            padding: EdgeInsets.only(left: 1.3.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 2.h,
                    ),
                    SizedBox(
                      width: 0.5.w,
                    ),
                    Text(
                      time,
                      style: TextStyle(
                          fontSize: 2.1.w, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 1.2.w,
                    ),
                    Icon(
                      Icons.location_on_sharp,
                      size: 2.h,
                    ),
                    Text(
                      classRoom,
                      style: TextStyle(
                          fontSize: 2.1.w, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.3.h,
                ),
                Text(
                  subject,
                  style:
                      TextStyle(fontSize: 3.6.w, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 1.1.h,
                      color: determineColor(),
                    ),
                    SizedBox(
                      width: 0.7.w,
                    ),
                    Text(
                      status,
                      style: TextStyle(
                          fontSize: 1.6.w, fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

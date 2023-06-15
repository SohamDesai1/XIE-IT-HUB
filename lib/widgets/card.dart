import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Card(),
  ));
}

class Card extends StatelessWidget {
  const Card({
    super.key,
    // required this.date,
//       required this.lesson,
//       required this.time
  });
//   final String lesson;
//   final String time;
//   final String date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 0.8 * MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 2),
            color: Colors.grey[170]),
        child: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Upcoming"),
                  SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 15,
                      ),
                      Text("12:23:02")
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "AI & DS: 1 hr",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 15,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text("2:30 PM,19 May")
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

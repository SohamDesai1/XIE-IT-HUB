import 'package:college_manager/utils/timeTable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MaterialApp(
    home: ExpandedTT(),
  ));
}

class ExpandedTT extends StatefulWidget {
  // final List tt;
  const ExpandedTT({super.key});

  @override
  State<ExpandedTT> createState() => _ExpandedTTState();
}

class _ExpandedTTState extends State<ExpandedTT> {
  var selectedDate = DateTime.now();
  var currDate = DateTime.now();
  List displayTT = [];
  List time = [
    "8:45-\n9:45",
    "9:45-\n10:45",
    "11:00-\n12:00",
    "12:00-\n1:00",
    "1:30-\n2:30",
    "2:30-\n3:30",
    "3:30-\n4:30"
  ];
  @override
  void initState() {
    super.initState();
    showTT(selectedDate);
  }

  void showTT(DateTime date) {
    if (date.weekday == 1) {
      displayTT = monday;
    }
    if (date.weekday == 2) {
      displayTT = tuesday;
    }
    if (date.weekday == 3) {
      displayTT = wednesday;
    }
    if (date.weekday == 4) {
      displayTT = thursday;
    }
    if (date.weekday == 5) {
      displayTT = friday;
    }
    if (date.weekday == 6) {
      displayTT = weekend;
    }
    if (date.weekday == 7) {
      displayTT = weekend;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: MediaQuery.sizeOf(context).width / 1.1,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 10),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Time Table",
                            style: GoogleFonts.acme(fontSize: 30),
                          ),
                          Text(
                            DateFormat('dd MMM yyyy').format(currDate),
                            style: GoogleFonts.acme(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width / 1.15,
                        height: 50,
                        child: HorizontalCalendar(
                          date: DateTime.now(),
                          initialDate: DateTime.now(),
                          textColor: Colors.black,
                          backgroundColor: Colors.white,
                          selectedColor: Colors.orange,
                          locale: Localizations.localeOf(context),
                          onDateSelected: (date) {
                            setState(() {
                              selectedDate = date;
                              showTT(selectedDate);
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 500,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              child: Center(child: Text(time[index])),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(displayTT[index]),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  );
                },
                itemCount: displayTT.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}

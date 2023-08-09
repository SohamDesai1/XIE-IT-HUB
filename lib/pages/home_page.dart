import 'package:college_manager/pages/attendance.dart';
import 'package:college_manager/widgets/bottom_nav_bar.dart';
import 'package:college_manager/widgets/time_table.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: const Text("Home Page"),
        actions: const [
          Center(
            child: Text(
              "Soham Desai",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.amber,
              child: Text("S"),
            ),
          )
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
      body: Column(
        children: [
          Stack(
            alignment: const Alignment(0, 3),
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.purple[200],
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.elliptical(60, 40),
                        bottomRight: Radius.elliptical(60, 40))),
              ),
              const TimeTable()
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AttendancePage())),
              child: const Text("Attendance manager"))
        ],
      ),
    );
  }
}

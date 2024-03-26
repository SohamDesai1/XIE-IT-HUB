import 'package:flutter/material.dart';

class Activities extends StatefulWidget {
  const Activities({super.key});

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xC90000FF),
        title: const Center(
          child: Text(
            "Achievements",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

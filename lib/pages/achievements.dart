import 'package:college_manager/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class Achievements extends StatefulWidget {
  const Achievements({super.key});

  @override
  State<Achievements> createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
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

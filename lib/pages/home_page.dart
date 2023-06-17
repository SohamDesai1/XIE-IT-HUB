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
        title: const Text("Home Page"),
      ),
      bottomNavigationBar: const BottomNavBar(),
      body: const Center(
        child: TimeTable(),
      ),
    );
  }
}

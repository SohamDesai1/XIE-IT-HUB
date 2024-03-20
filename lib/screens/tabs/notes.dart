import 'package:flutter/material.dart';

import '/widgets/bottom_nav_bar.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      appBar: AppBar(
        backgroundColor: const Color(0xC90000FF),
        title: const Center(
          child: Text(
            "Notes",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

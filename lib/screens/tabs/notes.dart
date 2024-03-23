import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

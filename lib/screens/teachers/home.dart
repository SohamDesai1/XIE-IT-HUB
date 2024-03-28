import 'package:college_manager/screens/teachers/cal_upload.dart';
import 'package:college_manager/screens/teachers/res_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeacherHome extends ConsumerStatefulWidget {
  const TeacherHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends ConsumerState<TeacherHome> {
  String? selectedOption;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
        child: Text("Upload files"),
      )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text('Calendar'),
              leading: Radio(
                value: "calendar",
                groupValue: selectedOption,
                activeColor: Colors.red,
                fillColor: MaterialStateProperty.all(Colors.red),
                splashRadius: 20,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Results'),
              leading: Radio(
                value: "results",
                groupValue: selectedOption,
                activeColor: Colors.blue,
                fillColor: MaterialStateProperty.all(Colors.blue),
                splashRadius: 25,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
              ),
            ),
            if (selectedOption == 'calendar') const CalendarUpload(),
            if (selectedOption == 'results') const ResultUpload(),
          ],
        ),
      ),
    );
  }
}

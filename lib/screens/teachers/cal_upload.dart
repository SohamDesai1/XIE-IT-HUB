// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CalendarUpload extends StatefulWidget {
  const CalendarUpload({super.key});

  @override
  State<CalendarUpload> createState() => _CalendarUploadState();
}

class _CalendarUploadState extends State<CalendarUpload> {
  String? value;
  String? dept;
  String? inst;
  String? instcal;
  String? deptcal;
  String? fileName;
  bool dropDown = false;
  bool isSelected = false;
  bool _isUploading = false;
  File? _pdfFile;

  List<DropdownMenuItem<String>> dropDownMenu = [];
  final month = DateTime.now().month;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    setValues();
    initializeDropDownMenu();
  }

  void setValues() {
    if (month >= 1 && month <= 6) {
      dept = "it_even";
      inst = "even_year_tt";
      instcal = "Academic Calendar-Even Sem-23-24.pdf";
      deptcal = 'IT_AcademicCalendar_2023-24_Even.pdf';
    } else if (month >= 7 && month <= 12) {
      dept = "it_odd";
      inst = "odd_year_tt";
      instcal = "Academic Calendar-Odd Sem-23-24.pdf";
      deptcal = 'IT_AcademicCalendar_2023-24_Odd.pdf';
    }
  }

  void initializeDropDownMenu() {
    dropDownMenu = [
      DropdownMenuItem(
        value: dept,
        child: const Text("Department Calendar"),
      ),
      DropdownMenuItem(
        value: inst,
        child: const Text("Institute Calendar"),
      ),
    ];
  }

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      _pdfFile = File(result.files.single.path!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cancelled')),
      );
    }
    setState(() {
      isSelected = true;
    });
  }

  Future<void> _uploadPDF() async {
    if (_pdfFile == null) {
      return;
    }

    setState(() {
      _isUploading = true;
    });

    if (value == dept) {
      fileName = deptcal!;
    } else if (value == inst) {
      fileName = instcal!;
    }

    try {
      Reference storageReference = _storage.ref().child('$fileName');
      UploadTask uploadTask = storageReference.putFile(_pdfFile!);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      String downloadUrl = await snapshot.ref.getDownloadURL();

      await _firestore.collection('utils').doc('pdfs').update({
        value!: downloadUrl,
      });

      setState(() {
        _isUploading = false;
        _pdfFile = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PDF uploaded successfully')),
      );
    } catch (e) {
      log('Error uploading PDF: $e');
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to upload PDF')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Calendar',
              style: TextStyle(fontSize: 24),
            ),
            DropdownButton(
                value: value,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 30,
                elevation: 16,
                style: const TextStyle(fontSize: 20, color: Colors.black),
                dropdownColor: Colors.amber,
                underline: const SizedBox(),
                onChanged: (newValue) {
                  setState(() {
                    value = newValue;
                    dropDown = true;
                  });
                },
                items: dropDownMenu),
          ],
        ),
        dropDown
            ? ElevatedButton(
                onPressed: _pickPDF,
                child: const Text('Select PDF'),
              )
            : const SizedBox(),
        const SizedBox(height: 20),
        if (_pdfFile != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_pdfFile!.path.split('/').last),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _pdfFile = null;
                      isSelected = false;
                    });
                  },
                  icon: const Icon(Icons.cancel))
            ],
          ),
        const SizedBox(height: 20),
        isSelected
            ? ElevatedButton(
                onPressed: _isUploading ? null : _uploadPDF,
                child: _isUploading
                    ? const CircularProgressIndicator()
                    : const Text('Upload PDF'),
              )
            : const SizedBox(),
      ],
    );
  }
}

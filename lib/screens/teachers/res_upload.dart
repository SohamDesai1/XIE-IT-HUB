// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ResultUpload extends StatefulWidget {
  const ResultUpload({super.key});

  @override
  State<ResultUpload> createState() => _ResultUploadState();
}

class _ResultUploadState extends State<ResultUpload> {
  String? value;
  String? fileName;
  bool dropDown = false;
  bool isSelected = false;
  bool _isUploading = false;
  File? _pdfFile;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  List<DropdownMenuItem<String>> dropDownMenu = [
    const DropdownMenuItem(
      value: "BE",
      child: Text("BE Results"),
    ),
    const DropdownMenuItem(
      value: "TE",
      child: Text("TE Results"),
    ),
    const DropdownMenuItem(
      value: "SE",
      child: Text("SE Results"),
    ),
  ];

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg'],
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

    if (value == "BE") {
      fileName = "results_BE.jpg";
    } else if (value == "TE") {
      fileName = "results_TE.jpg";
    } else if (value == "SE") {
      fileName = "results_SE.jpg";
    }

    try {
      Reference storageReference = _storage.ref().child('$fileName');
      UploadTask uploadTask = storageReference.putFile(_pdfFile!);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      String downloadUrl = await snapshot.ref.getDownloadURL();

      await _firestore.collection('utils').doc('results').update({
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
              'Results',
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
                child: const Text('Select image'),
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
                    : const Text('Upload image'),
              )
            : const SizedBox(),
      ],
    );
  }
}

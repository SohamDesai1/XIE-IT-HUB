import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Syllabus extends StatefulWidget {
  const Syllabus({super.key});

  @override
  State<Syllabus> createState() => _SyllabusState();
}

class _SyllabusState extends State<Syllabus> {
  @override
  void initState() {
    super.initState();
    getSyllabus();
  }

  var db = FirebaseFirestore.instance;
  Map<String, dynamic>? documentData;
  List year = [
    "3rd SEM",
    "4th SEM",
    "5th SEM",
    "6th SEM",
    "7th SEM",
    "8th SEM"
  ];
  Map<String, String> semToKey = {
    "3rd SEM": "sem3_p",
    "4th SEM": "sem4_p",
    "5th SEM": "sem5_p",
    "6th SEM": "sem6_p",
    "7th SEM": "sem7_p",
    "8th SEM": "sem8_p",
  };

  void getSyllabus() async {
    final docRef = db.collection("utils").doc("pdfs");
    var docData = await docRef.get();
    if (docData.exists) {
      documentData = docData.data() as Map<String, dynamic>;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xC90000FF),
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 13.w),
            child: const Text(
              "Syllabus",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: 55.h,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 1.5.h),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      String? urlKey = semToKey[year[index]];
                      String url = documentData?[urlKey];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PDFScreen1(
                              path: url,
                              sem: year[index],
                            ),
                          ));
                    },
                    child: Container(
                      width: 95.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(child: Text(year[index])),
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: year.length,
        ),
      ),
    ));
  }
}

class PDFScreen1 extends StatefulWidget {
  final String path;
  final String sem;
  const PDFScreen1({super.key, required this.path, required this.sem});

  @override
  State<PDFScreen1> createState() => _PDFScreen1State();
}

class _PDFScreen1State extends State<PDFScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 23.w),
          child: Text(widget.sem),
        ),
      ),
      body: SfPdfViewer.network(widget.path),
    );
  }
}

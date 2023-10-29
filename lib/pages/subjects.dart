import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Subjects extends StatefulWidget {
  const Subjects({super.key});

  @override
  State<Subjects> createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  List<String> subjectNames = [];
  List<String> labNames = [];
  var db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getSubjects();
  }

  getSubjects() async {
    final docRef = db.collection("BE").doc("SEM 7").collection("subjects");
    QuerySnapshot docs = await docRef.where("type", isEqualTo: "theory").get();
    for (QueryDocumentSnapshot doc in docs.docs) {
      subjectNames.add(doc['subject_name']);
    }
    log(subjectNames.toString());
    QuerySnapshot docs1 = await docRef.where("type", isEqualTo: "lab").get();
    for (QueryDocumentSnapshot doc1 in docs1.docs) {
      labNames.add(doc1['subject_name']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xC90000FF),
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: const Text(
              "Subjects",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 3.h, left: 22.w),
              child: Row(
                children: [
                  const Text(
                    "Thoery",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  const Text(
                    "Practical",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 65.w,
              child: const Divider(
                thickness: 2,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: SizedBox(
                    height: 75.h,
                    width: 25.w,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              width: 43.w,
                              height: 20.5.h,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                  border: Border.all(color: Colors.black),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 4.0,
                                      offset: Offset(3.0, 0),
                                    )
                                  ],
                                  color: Colors.white),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Image.asset(
                                      "assets/images/books.png",
                                      width: 17.w,
                                      height: 10.h,
                                    )),
                                    Text(subjectNames[index]),
                                    SizedBox(
                                      height: 2.85.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            )
                          ],
                        );
                      },
                      itemCount: subjectNames.length,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: SizedBox(
                    height: 75.h,
                    width: 25.w,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              width: 43.w,
                              height: 20.5.h,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                  border: Border.all(color: Colors.black),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 4.0,
                                      offset: Offset(3.0, 0),
                                    )
                                  ],
                                  color: Colors.white),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Image.asset(
                                      "assets/images/prac.png",
                                      width: 17.w,
                                      height: 10.h,
                                    )),
                                    Text(labNames[index]),
                                    SizedBox(
                                      height: 2.85.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            )
                          ],
                        );
                      },
                      itemCount: labNames.length,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

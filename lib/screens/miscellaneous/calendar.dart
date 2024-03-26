import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late String institute;
  late String it;
  List<String> links = [];

  Future<List<String>> getLink() async {
    var db = FirebaseFirestore.instance;
    final docref = db.collection('utils').doc('pdfs');
    final doc = await docref.get();
    final data = doc.data();
    institute = data!['even_year_tt'];
    links.add(institute);
    it = data['it_even'];
    links.add(it);

    return links;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xC90000FF),
          title: Center(
            child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: const Text(
                "Academic Calendar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        body: FutureBuilder<List<String>>(
          future: getLink(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var links = snapshot.data!;
              return Padding(
                padding: EdgeInsets.only(
                  top: 1.5.h,
                ),
                child: SizedBox(
                  height: 55.h,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Institute Calendar",
                          style: TextStyle(fontSize: 20),
                        ),
                        Divider(color: Colors.black, endIndent: 15.w),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PDFScreen(
                                  text: "Institute",
                                  link: links[0],
                                ),
                              )),
                          child: SizedBox(
                            height: 6.h,
                            width: 60.w,
                            child: const Center(child: Text("Show PDF")),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        const Text(
                          "Department Calendar",
                          style: TextStyle(fontSize: 20),
                        ),
                        Divider(color: Colors.black, endIndent: 15.w),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PDFScreen(
                                  text: " Department",
                                  link: links[1],
                                ),
                              )),
                          child: SizedBox(
                            height: 6.h,
                            width: 60.w,
                            child: const Center(child: Text("Show PDF")),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error fetching categories"));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class PDFScreen extends StatelessWidget {
  final String text;
  final String link;
  const PDFScreen({super.key, required this.text, required this.link});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(text),
      ),
      body: SfPdfViewer.network(link),
    );
  }
}

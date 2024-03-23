import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tuple/tuple.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late String oddLink;
  late String evenLink;
  List<String> links = [];

  Future<Tuple2<List<String>, List<String>>> getLink() async {
    List<String> year = ["ODD Year", "EVEN Year"];
    var db = FirebaseFirestore.instance;
    final docref = db.collection('utils').doc('pdfs');
    final doc = await docref.get();
    final data = doc.data();
    oddLink = data!['odd_year_tt'];
    links.add(oddLink);
    evenLink = data['even_year_tt'];
    links.add(evenLink);

    return Tuple2<List<String>, List<String>>(year, links);
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
        body: FutureBuilder<Tuple2<List<String>, List<String>>>(
          future: getLink(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var years = snapshot.data!.item1;
              var links = snapshot.data!.item2;
              return Padding(
                padding: EdgeInsets.only(
                  top: 1.5.h,
                ),
                child: SizedBox(
                  height: 55.h,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PDFScreen(
                                    text: years[index],
                                    link: links[index],
                                  ),
                                )),
                            child: Container(
                              height: 6.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(child: Text(years[index])),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          )
                        ],
                      );
                    },
                    itemCount: years.length,
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

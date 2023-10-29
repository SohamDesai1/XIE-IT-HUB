import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List year = ["ODD Year", "EVEN Year"];
  // List link = ["ODD Year", "EVEN Year"];
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
        body: Padding(
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
                            builder: (context) => const PDFScreen(),
                          )),
                      child: Container(
                        height: 6.h,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text(year[index])),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    )
                  ],
                );
              },
              itemCount: year.length,
            ),
          ),
        ),
      ),
    );
  }
}

class PDFScreen extends StatelessWidget {
  const PDFScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SfPdfViewer.network(
          'https://firebasestorage.googleapis.com/v0/b/college-manager-b1302.appspot.com/o/Academic%20Calendar-Odd%20Sem-23-24.pdf?alt=media&token=3babbf44-9768-4740-96be-8ee2657aabf0'),
    );
  }
}

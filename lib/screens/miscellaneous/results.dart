import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Results extends StatefulWidget {
  const Results({super.key});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  List<String> results = [];

  Future<List> getreults() async {
    var db = FirebaseFirestore.instance;
    final docref = db.collection('utils').doc('results');
    final doc = await docref.get();
    final data = doc.data();
    results.add(data!['BE']);
    results.add(data['TE']);
    results.add(data['SE']);
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: const Text(
              "Results",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder(
              future: getreults(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var links = snapshot.data!;
                  return Column(
                    children: [
                      SizedBox(
                        child: Image.network(
                          links[0],
                          fit: BoxFit.contain,
                          height: 53.h,
                          errorBuilder: (ctx, s, err) {
                            return const Text("No results found");
                          },
                        ),
                      ),
                      const Center(
                        child: Text("FINAL YEAR"),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        child: Image.network(
                          links[0],
                          fit: BoxFit.contain,
                          height: 53.h,
                          errorBuilder: (ctx, s, err) {
                            return const Text("No results found");
                          },
                        ),
                      ),
                      const Center(
                        child: Text("THIRD YEAR"),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        child: Image.network(
                          links[0],
                          fit: BoxFit.contain,
                          height: 53.h,
                          errorBuilder: (ctx, s, err) {
                            return const Text("No results found");
                          },
                        ),
                      ),
                      const Center(
                        child: Text("SECOND YEAR"),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error fetching categories"));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }
}

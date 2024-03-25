import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuple/tuple.dart';
import 'dart:developer';

final hiveDataProvider =
    FutureProvider<Tuple2<List<String>, List<String>>>((ref) async {
  final Tuple2<List<String>, List<String>> data = await getSubjects();
  return data;
});

var db = FirebaseFirestore.instance;
List<String> subjectNames = [];
List<String> labNames = [];
late String sem;
Future<Tuple2<List<String>, List<String>>> getSubjects() async {
  var hiveBox = await Hive.openBox('students');
  var year = hiveBox.get(1).year;
  log(year);
  final month = DateTime.now().month;

  if (year == "SE" && month >= 1 && month <= 6) {
    sem = "SEM 4";
  } else if (year == "SE" && month >= 7 && month <= 12) {
    sem = "SEM 3";
  } else if (year == "TE" && month >= 1 && month <= 6) {
    sem = "SEM 6";
  } else if (year == "TE" && month >= 7 && month <= 12) {
    sem = "SEM 5";
  } else if (year == "BE" && month >= 1 && month <= 6) {
    sem = "SEM 8";
  } else if (year == "BE" && month >= 7 && month <= 12) {
    sem = "SEM 7";
  }

  final docRef = db.collection(year).doc(sem).collection("subjects");
  QuerySnapshot docs = await docRef.where("type", isEqualTo: "theory").get();
  for (QueryDocumentSnapshot doc in docs.docs) {
    subjectNames.add(doc['subject_name']);
  }
  QuerySnapshot docs1 = await docRef.where("type", isEqualTo: "lab").get();
  for (QueryDocumentSnapshot doc1 in docs1.docs) {
    labNames.add(doc1['subject_name']);
  }
  await hiveBox.close();
  return Tuple2<List<String>, List<String>>(subjectNames, labNames);
}

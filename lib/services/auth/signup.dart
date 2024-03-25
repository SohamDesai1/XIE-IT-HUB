import 'package:flutter/foundation.dart';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/models/student.dart';

final signupProvider = ChangeNotifierProvider((ref) => Signup());

class Signup extends ChangeNotifier {
  signupWithEmail(String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  saveStudent(
      int xieID, String fullName, String email, String year, int rollNo) async {
    var studBox = await Hive.openBox<Student>('students');
    studBox.add(Student(xieID, fullName, email, year, rollNo));
    await studBox.close();
  }
}

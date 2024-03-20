import 'package:flutter/foundation.dart';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final logoutProvider = ChangeNotifierProvider((ref) => Logout());


class Logout extends ChangeNotifier {
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      notifyListeners();
    } catch (error) {
      log(error.toString());
    }
  }
}

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final loginProvider = ChangeNotifierProvider((ref) => Login());

class Login extends ChangeNotifier {
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = authResult.user;

        if (user != null && !user.email!.endsWith('@student.xavier.ac.in')) {
          await FirebaseAuth.instance
              .signOut(); // Sign out if domain is not @student.xavier.ac.in
          return null;
        }

        notifyListeners(); // Notify listeners about the sign-in state change
        return user;
      }
    } catch (error) {
      log(error.toString());
      return null;
    }
    return null;
  }

  Future<void> signInWithEmail(String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      notifyListeners(); // Notify listeners about the sign-in state change
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
  }

  Future<UserCredential?> loginWithGithub() async {
    try {
      GithubAuthProvider githubProvider = GithubAuthProvider();

      return await FirebaseAuth.instance.signInWithProvider(githubProvider);
    } catch (e) {
      debugPrint('Login failed: $e');
      return null;
    }
  }
  
}
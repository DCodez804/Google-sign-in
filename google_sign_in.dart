import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;
  bool _isError;
  bool _isLoggedOut;

  GoogleSignInProvider() {
    _isSigningIn = false;
    _isError = false;
    _isLoggedOut = false;
  }

  bool get isSigningIn => _isSigningIn;
  bool get isError => _isError;
  bool get isLoggedOut => _isLoggedOut;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  set isError(bool isError) {
    _isError = isError;
    notifyListeners();
  }

  set isLoggedOut(bool isLoggedOut) {
    _isLoggedOut = isLoggedOut;
    notifyListeners();
  }

  Future login() async {
    isSigningIn = true;
    isError = false;

    final user = await googleSignIn.signIn().catchError(
      (error) {
        print('$error');
        isError = true;
        return null;
      },
    );
    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      isSigningIn = false;
    }
  }

  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    isLoggedOut = true;
    print('log $isLoggedOut');
  }
}

import 'package:cmsc23project/api/firebase_google_sign_in_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GoogleAuthProvider with ChangeNotifier {
  late FirebaseGoogleSignInAPI authService;
  late Stream<User?> _uStream;

  GoogleAuthProvider() {
    authService = FirebaseGoogleSignInAPI();
    fetchAuthentication();
  }

  Stream<User?> get userStream => _uStream;
  User? get user => authService.getUser();

  void fetchAuthentication() {
    _uStream = authService.userSignedIn();

    notifyListeners();
  }

  Future<UserCredential> signIn() async {
    UserCredential message = await authService.signInWithGoogle();
    notifyListeners();

    return message;
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}

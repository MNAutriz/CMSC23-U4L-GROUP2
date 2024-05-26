import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/api/firebase_username_api.dart';
import 'package:cmsc23project/models/username_model.dart';
import 'package:flutter/material.dart';

class UsernameProvider with ChangeNotifier {
  FirebaseUsernameAPI firebaseService = FirebaseUsernameAPI();
  late Stream<QuerySnapshot> _usernamesStream;
  late CollectionReference<Map<String, dynamic>> _usernamesCollection;

  UsernameProvider() {
    fetchUsernames();
    usernamesCollection();
  }
  // getter
  Stream<QuerySnapshot> get username => _usernamesStream;

  //fetch organizations
  void fetchUsernames() {
    _usernamesStream = firebaseService.getAllUsernames();
    notifyListeners();
  }

  //add username method
  void addUsername(Username username) async {
    String message =
        await firebaseService.addUsername(username.toJson(username));
    print(message);
    notifyListeners();
  }

  //delete username method
  void deleteUsername(String id) async {
    await firebaseService.deleteUsername(id);
    notifyListeners();
  }

// getter for username collection
  CollectionReference<Map<String, dynamic>> get usernameCollection =>
      _usernamesCollection;

  //fetch username collection
  usernamesCollection() {
    _usernamesCollection = firebaseService.getUsernameCollection();
    notifyListeners();
  }
}

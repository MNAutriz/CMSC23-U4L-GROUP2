import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/api/firebase_admin_api.dart';

import 'package:flutter/material.dart';

class AdminProvider with ChangeNotifier {
  FirebaseAdminAPI firebaseService = FirebaseAdminAPI();
  late CollectionReference<Map<String, dynamic>> _adminsCollection;

  //provider for admin collection
  AdminProvider() {
    fetchAdmins();
  }

  // getter for admin collection
  CollectionReference<Map<String, dynamic>> get admin => _adminsCollection;

  //fetch admins collection
  fetchAdmins() {
    _adminsCollection = firebaseService.getAllAdmins();
    notifyListeners();
  }
}

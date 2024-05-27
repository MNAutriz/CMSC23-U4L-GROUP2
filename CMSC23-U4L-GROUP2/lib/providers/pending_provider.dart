import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cmsc23project/api/firebase_pending_api.dart';
import 'package:cmsc23project/models/organization_model.dart';
import 'package:flutter/material.dart';

class PendingProvider with ChangeNotifier {
  FirebasePendingAPI firebaseService = FirebasePendingAPI();
  late Stream<QuerySnapshot> _pendingStream;

  PendingProvider() {
    fetchPending();
  }
  // getter
  Stream<QuerySnapshot> get pending => _pendingStream;

  //fetch pending applications
  void fetchPending() {
    _pendingStream = firebaseService.getAllPending();
    notifyListeners();
  }

  //add pending application for organization
  void addPending(Organization organization) async {
    String message =
        await firebaseService.addPending(organization.toJson(organization));
    print(message);
    notifyListeners();
  }

  //delete pending method
  void deletePending(String id) async {
    await firebaseService.deletePending(id);
    notifyListeners();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/api/firebase_organization_api.dart';
import 'package:cmsc23project/models/organization_model.dart';
import 'package:flutter/material.dart';

class OrganizationProvider with ChangeNotifier {
  FirebaseOrganizationAPI firebaseService = FirebaseOrganizationAPI();
  late Stream<QuerySnapshot> _orgsStream;

  OrganizationProvider() {
    fetchOrganizations();
  }
  // getter
  Stream<QuerySnapshot> get organization => _orgsStream;

  //fetch organizations
  void fetchOrganizations() {
    _orgsStream = firebaseService.getAllOrganizations();
    notifyListeners();
  }

  //add organization method
  void addOrganization(Organization organization) async {
    String message = await firebaseService
        .addOrganization(organization.toJson(organization));
    print(message);
    notifyListeners();
  }

  //delete organization method
  void deleteOrganization(String id) async {
    await firebaseService.deleteOrganization(id);
    notifyListeners();
  }
}

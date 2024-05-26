import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/api/firebase_donationform_api.dart';
import 'package:flutter/material.dart';

class DonorFormProvider with ChangeNotifier{
  FirebaseDonationFormAPI firebaseService = FirebaseDonationFormAPI();
  late Stream<QuerySnapshot> _formsStream;

  DonorFormProvider() {
    _formsStream = firebaseService.getAllForms();
  }

  Stream<QuerySnapshot> get formsStream => _formsStream;

  Future<String> addForm(Map<String, dynamic> form) async {
    return firebaseService.addForm(form);
  }

  Future<String> deleteForm(String id) async {
    return firebaseService.deleteForm(id);
  }
}

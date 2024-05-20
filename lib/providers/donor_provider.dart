import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/api/firebase_donor_api.dart';
import 'package:cmsc23project/models/donor_model.dart';
import 'package:flutter/material.dart';

class DonorProvider with ChangeNotifier {
  FirebaseDonorAPI firebaseService = FirebaseDonorAPI();
  late Stream<QuerySnapshot> _donorsStream;

  DonorProvider() {
    fetchDonors();
  }
  // getter
  Stream<QuerySnapshot> get donor => _donorsStream;

  //fetch donors
  void fetchDonors() {
    _donorsStream = firebaseService.getAllDonors();
    notifyListeners();
  }

  //add donor method
  void addDonor(Donor donor) async {
    String message = await firebaseService.addDonor(donor.toJson(donor));
    print(message);
    notifyListeners();
  }

  //delete donor method
  void deleteDonor(String id) async {
    await firebaseService.deleteDonor(id);
    notifyListeners();
  }
}

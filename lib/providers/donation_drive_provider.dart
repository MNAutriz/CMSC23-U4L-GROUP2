import 'package:cmsc23project/api/firebase_donationdrive_api.dart';
import 'package:cmsc23project/pages/homepage/donation_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonationDriveProvider with ChangeNotifier {
  final FirebaseDonationDriveAPI firebaseService = FirebaseDonationDriveAPI();
  late Stream<QuerySnapshot> _drivesStream;

  DonationDriveProvider() {
    _drivesStream = firebaseService.getAllDonationDrives();
  }

  Stream<QuerySnapshot> get drivesStream => _drivesStream;

  Future<void> addDonationDrive(Map<String, dynamic> drive) async {
    await firebaseService.addDonationDrive(drive);
    notifyListeners();
  }

  Future<void> deleteDonationDrive(String id) async {
    await firebaseService.deleteDonationDrive(id);
    notifyListeners();
  }

  Future<void> editDonationDrive(String id, Map<String, dynamic> updatedDrive) async {
    await firebaseService.editDonationDrive(id, updatedDrive);
    notifyListeners();
  }
}

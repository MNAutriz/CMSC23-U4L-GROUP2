import 'package:cmsc23project/pages/homepage/donation_model.dart';
import 'package:flutter/material.dart';
import '../pages/donationdrivepage/donation_drive_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DonationDriveProvider with ChangeNotifier {
  final List<DonationDrive> _donationDrives = [];

  List<DonationDrive> get donationDrives => _donationDrives;

  final CollectionReference _donationDrivesCollection = FirebaseFirestore.instance.collection('donation_drives');

  DonationDriveProvider() {
    fetchDonationDrives();
  }

  void fetchDonationDrives() async {
    final snapshot = await _donationDrivesCollection.get();
    _donationDrives.clear();
    for (var doc in snapshot.docs) {
      _donationDrives.add(DonationDrive.fromJson(doc.data() as Map<String, dynamic>));
    }
    notifyListeners();
  }

  Future<void> addDonationDrive(DonationDrive donationDrive) async {
    final docRef = _donationDrivesCollection.doc(donationDrive.id);
    await docRef.set(donationDrive.toJson());
    _donationDrives.add(donationDrive);
    notifyListeners();
  }

  Future<void> updateDonationDrive(String id, DonationDrive updatedDrive) async {
    final docRef = _donationDrivesCollection.doc(id);
    await docRef.update(updatedDrive.toJson());
    final index = _donationDrives.indexWhere((drive) => drive.id == id);
    if (index != -1) {
      _donationDrives[index] = updatedDrive;
      notifyListeners();
    }
  }

  Future<void> deleteDonationDrive(String id) async {
    final docRef = _donationDrivesCollection.doc(id);
    await docRef.delete();
    _donationDrives.removeWhere((drive) => drive.id == id);
    notifyListeners();
  }

  void addDonationToDrive(String driveId, Donation donation) {
    try {
      final drive = _donationDrives.firstWhere((drive) => drive.id == driveId);
      drive.donations.add(donation);
      updateDonationDrive(drive.id, drive);
      notifyListeners();
    } catch (e) {
      print('Error adding donation to drive: $e');
    }
  }
}

import 'package:flutter/material.dart';
import '../models/donation_drive_model.dart';

class DonationDriveProvider with ChangeNotifier {
  List<DonationDrive> _donationDrives = [];
  int _selectedIndex = 0;

  List<DonationDrive> get donationDrives => _donationDrives;
  int get selectedIndex => _selectedIndex;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void addDonationDrive(DonationDrive donationDrive) {
    _donationDrives.add(donationDrive);
    notifyListeners();
  }

  void updateDonationDrive(String id, DonationDrive newDrive) {
    final index = _donationDrives.indexWhere((drive) => drive.id == id);
    if (index >= 0) {
      _donationDrives[index] = newDrive;
      notifyListeners();
    }
  }

  void deleteDonationDrive(String id) {
    _donationDrives.removeWhere((drive) => drive.id == id);
    notifyListeners();
  }

  DonationDrive findById(String id) {
    return _donationDrives.firstWhere((drive) => drive.id == id);
  }
}

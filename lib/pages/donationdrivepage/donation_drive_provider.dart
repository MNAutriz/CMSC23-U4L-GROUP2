import 'package:flutter/material.dart';
import '../homepage/donation_model.dart';
import '../donationdrivepage/donation_drive_model.dart';
import 'notification_service.dart';

import 'package:flutter/material.dart';
import '../homepage/donation_model.dart';
import '../donationdrivepage/donation_drive_model.dart';

import 'package:flutter/material.dart';

class DonationDriveProvider with ChangeNotifier {
  final List<DonationDrive> _donationDrives = [
    DonationDrive(
      id: '1',
      title: 'Education Drive 2024',
      description: 'Help build a school in rural Africa.',
      imageUrls: [
        'https://adra.ph/wp-content/uploads/2017/09/Gift-Boxes-Aeta-4-1024x683.jpg',
      ],
      donations: [],
    ),
    DonationDrive(
      id: '2',
      title: 'Environmental Conservation Drive 2024',
      description: 'Save the rainforest and safeguard endangered species.',
      imageUrls: [
        'https://spweb-uploads.s3.theark.cloud/2013/03/1827PH-G-022_Philippines.jpg',
      ],
      donations: [],
    ),
  ];

  List<DonationDrive> get donationDrives => _donationDrives;

  void addDonationDrive(DonationDrive donationDrive) {
    print('Adding donation drive: ${donationDrive.title}');
    _donationDrives.add(donationDrive);
    notifyListeners();
  }

  void updateDonationDrive(String id, DonationDrive updatedDrive) {
    final index = _donationDrives.indexWhere((drive) => drive.id == id);
    if (index != -1) {
      _donationDrives[index] = updatedDrive;
      notifyListeners();
    } else {
      print('No donation drive found with id: $id');
    }
  }

  void deleteDonationDrive(String id) {
    _donationDrives.removeWhere((drive) => drive.id == id);
    notifyListeners();
  }

  void addDonationToDrive(String driveId, Donation donation) {
    try {
      final drive = _donationDrives.firstWhere((drive) => drive.id == driveId);
      drive.donations.add(donation);
      notifyListeners();
    } catch (e) {
      print('Error adding donation to drive: $e');
    }
  }
}

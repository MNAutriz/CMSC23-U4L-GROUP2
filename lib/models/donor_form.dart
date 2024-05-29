import 'dart:io';
import 'package:flutter/material.dart';

// enum for donation status to be updated by org
enum Status{
  pending, // 0
  confirmed, // 1
  scheduledForPickup,
  complete,
  cancelled
}

class DonorForm {

  String donorEmail;
  String orgId;
  String orgName;

  String donationDriveName;
  String donationDriveId;

  List<String> donationTypes;
  bool forPickup;
  double weight;
  String weightUnit;
  String? donationPhoto;
  DateTime donationDateTime;
  String? contactNo;
  List<String>? pickupAddresses;
  Status status;

  DonorForm({
    required this.donationDriveName,
    required this.donorEmail,
    required this.orgId,
    required this.orgName,
    required this.donationTypes,
    required this.forPickup,
    required this.weight,
    required this.weightUnit,
    required this.donationPhoto,
    required this.donationDateTime,
    required this.donationDriveId,
    this.contactNo,
    this.pickupAddresses,
    required this.status,
  });

  factory DonorForm.fromJson(Map<String, dynamic> json) {
    // add default values if null
    String donationDriveName = json['donationDriveName'];
    String donationDriveId = json['donationDriveId'];
    String donorEmail = json['donorEmail'];
    String orgId = json['orgId'];
    String orgName = json['orgName'];
    List<String> donationTypes = List<String>.from(json['donationTypes']);
    bool forPickup = json['forPickup'] ?? false;
    double weight = json['weight'] ?? 0.0;
    String weightUnit = json['weightUnit'] ?? '';
    String? donationPhoto = json['donationPhoto'];
    DateTime donationDateTime = DateTime.parse(json['donationDateTime']);
    String? contactNo = json['contactNo'];
    List<String>? pickupAddresses = json['pickupAddresses'] != null
        ? List<String>.from(json['pickupAddresses'])
        : null;
    Status status = json['status'];

    return DonorForm(
      donationDriveName: donationDriveName,
      donationDriveId: donationDriveId,
      donorEmail: donorEmail,
      orgId: orgId,
      orgName: orgName,
      donationTypes: donationTypes,
      forPickup: forPickup,
      weight: weight,
      weightUnit: weightUnit,
      donationPhoto: donationPhoto,
      donationDateTime: donationDateTime,
      contactNo: contactNo,
      pickupAddresses: pickupAddresses,
      status: status
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'donationDriveName': donationDriveName,
      'donationDriveId': donationDriveId,
      'donorEmail': donorEmail,
      'orgId': orgId,
      'orgName': orgName,
      'donationTypes': donationTypes,
      'forPickup': forPickup,
      'weight': weight,
      'weightUnit': weightUnit,
      'donationPhoto': donationPhoto,
      'donationDateTime': donationDateTime.toIso8601String(),
      'contactNo': contactNo,
      'pickupAddresses': pickupAddresses,
      'status': enumToInt(status) // convert to int so that it can be uploaded to firebase
    };
  }

  // convert Status enum to int by using its index
  int enumToInt(Status status){
    return status.index;
  }
}

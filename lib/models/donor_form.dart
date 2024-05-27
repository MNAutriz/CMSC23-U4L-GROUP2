import 'dart:io';
import 'package:flutter/material.dart';

class DonorForm {
  String donorEmail;

  List<String> donationTypes;
  bool forPickup;
  double weight;
  String weightUnit;
  String? donationPhoto;
  DateTime donationDateTime;
  String? contactNo;
  List<String>? pickupAddresses;

  DonorForm({
    required this.donorEmail,
    required this.donationTypes,
    required this.forPickup,
    required this.weight,
    required this.weightUnit,
    required this.donationPhoto,
    required this.donationDateTime,
    this.contactNo,
    this.pickupAddresses,
  });

  factory DonorForm.fromJson(Map<String, dynamic> json) {
    // add default values if null
    String donorEmail = json['donorEmail'];
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

    return DonorForm(
      donorEmail: donorEmail,
      donationTypes: donationTypes,
      forPickup: forPickup,
      weight: weight,
      weightUnit: weightUnit,
      donationPhoto: donationPhoto,
      donationDateTime: donationDateTime,
      contactNo: contactNo,
      pickupAddresses: pickupAddresses,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'donorEmail': donorEmail,
      'donationTypes': donationTypes,
      'forPickup': forPickup,
      'weight': weight,
      'weightUnit': weightUnit,
      'donationPhoto': donationPhoto,
      'donationDateTime': donationDateTime.toIso8601String(),
      'contactNo': contactNo,
      'pickupAddresses': pickupAddresses,
    };
  }
}

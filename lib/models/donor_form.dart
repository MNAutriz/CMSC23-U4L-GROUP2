import 'dart:io';
import 'package:flutter/material.dart';

class DonorForm {
  List<String> donationTypes;
  bool forPickup;
  double weight;
  File donationPhoto;
  DateTime donationDate;
  TimeOfDay donationTime;
  String? contactNo;
  String? pickupAddress;

  DonorForm({
    required this.donationTypes,
    required this.forPickup,
    required this.weight,
    required this.donationPhoto,
    required this.donationDate,
    required this.donationTime,
    this.contactNo,
    this.pickupAddress,
  });

  // TODO: COMPLETE HEHE
  // factory DonorForm.fromJson(Map<String, dynamic> json) {
  //   return DonorForm(
  //     donationTypes: List<String>.from(json['donationTypes']),
  //     forPickup: json['forPickup'],
  //     weight: json['weight'],
  //     donationPhoto: json['donationPhoto'],
  //     donationTime: json[]
  //   );
  // }

  Map<String, dynamic> toJson() {
    return {
      'donationTypes': donationTypes,
      'forPickup': forPickup,
      'weight': weight,
      'donationPhoto': donationPhoto.path,
      'donationDate': donationDate,
      'donationTime': donationTime,
      'contactNo': contactNo,
      'pickupAddress': pickupAddress,
    };
  }
}

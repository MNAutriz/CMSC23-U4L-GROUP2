import 'dart:io';
import 'package:flutter/material.dart';

class DonorForm {
  List<String> donationTypes;
  bool forPickup;
  double weight;
  String weightUnit;
  String? donationPhoto;
  DateTime donationDateTime;
  String? contactNo;
  List<String>? pickupAddresses;

  DonorForm({
    required this.donationTypes,
    required this.forPickup,
    required this.weight,
    required this.weightUnit,
    required this.donationPhoto,
    required this.donationDateTime,
    this.contactNo,
    this.pickupAddresses,
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
      'donationPhoto': donationPhoto,
      // 'donationDate': donationDate,
      // 'donationTime': donationTime,
      'contactNo': contactNo,
      'pickupAddress': pickupAddresses,
    };
  }
}

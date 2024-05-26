// import 'dart:io';

// import 'package:cmsc23project/models/donor_form.dart';
// import 'package:cmsc23project/pages/donateformpage/fields/upload_photo/image_constant.dart';
// import 'package:flutter/material.dart';

// class DonorFormProvider with ChangeNotifier {
//   // ignore: prefer_final_fields
//   DonorForm _donorForm = DonorForm(
//     donationTypes: [],
//     forPickup: false,
//     weight: 0.0,
//     weightUnit: 'kg',
//     donationPhoto: '',

//   );

//   // getters
//   List<String> get donationTypes => _donorForm.donationTypes;
//   bool get forPickup => _donorForm.forPickup;
//   double get weight => _donorForm.weight;
//   String? get donationPhoto => _donorForm.donationPhoto;
//   DateTime get donationDate => _donorForm.donationDate;
//   TimeOfDay get donationTime => _donorForm.donationTime;
//   String? get contactNo => _donorForm.contactNo;
//   List<String>? get pickupAddress => _donorForm.pickupAddresses;

//   // setters
//   void setDonationTypes(Map<String, bool> isCheckedMap) {
//     final List<String> types = isCheckedMap.entries.where((entry) => entry.value).map((entry) => entry.key).toList(); // convert map to list with keys as elements
//     _donorForm.donationTypes = types;
//     debugPrint(_donorForm.donationTypes.toString());
//     notifyListeners();
//   }

//   void setForPickup(bool value) {
//     _donorForm.forPickup = value;
//     debugPrint(_donorForm.forPickup.toString());
//     notifyListeners();
//   }

//   void setWeight(double value) {
//     _donorForm.weight = value;
//     debugPrint(_donorForm.weight.toString());
//     notifyListeners();
//   }

//   void setWeightUnit(String unit) {
//     _donorForm.weightUnit = unit;
//     debugPrint(_donorForm.weightUnit);
//     notifyListeners();
//   }

//   void setDonationPhoto(File photo) {
//     _donorForm.donationPhoto = ImageConstants().convertToBase64(photo);
//     debugPrint(_donorForm.donationPhoto.toString());
//     notifyListeners();
//   }

//   // void setDonationDate(DateTime date) {
//   //   _donorForm.donationDate = date;
//   //   debugPrint(date.toString());
//   //   notifyListeners();
//   // }

//   // void setDonationTime(TimeOfDay time) {
//   //   _donorForm.donationTime = time;
//   //   debugPrint(time.toString());
//   //   notifyListeners();
//   // }

//   void setContactNo(String? contactNo) {
//     _donorForm.contactNo = contactNo;
//     debugPrint(contactNo.toString());
//     notifyListeners();
//   }

//   // void setPickupAddress(String? address) {
//   //   _donorForm.pickupAddresses = ;
//   //   debugPrint(address);
//   //   notifyListeners();
//   // }

//   void resetForm() {
    
//   }
// }
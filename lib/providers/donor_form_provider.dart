import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/api/firebase_donationform_api.dart';
import 'package:flutter/material.dart';

class DonorFormProvider with ChangeNotifier{
  FirebaseDonationFormAPI firebaseService = FirebaseDonationFormAPI();
  late Stream<QuerySnapshot> _formsStream;

  DonorFormProvider() {
    _formsStream = firebaseService.getAllForms();
  }

  Stream<QuerySnapshot> get formsStream => _formsStream;

  Future<String> addForm(Map<String, dynamic> form) async {
    return firebaseService.addForm(form);
  }

  Future<String> deleteForm(String id) async {
    return firebaseService.deleteForm(id);
  }

  Future<void> updateForm(String id, Map<String, dynamic> updatedForm) async {
    await firebaseService.updateForm(id, updatedForm);
    notifyListeners();
  }

  // Future getFormById(String id) async {
  //   await firebaseService.getFormById(id);
  //   notifyListeners();
  // }
  Future<Map<String, dynamic>?> getFormById(String id) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await firebaseService.getFormById(id);
    return snapshot.data();
  }

  Future<void> updateDonationFormStatus(String documentId) async {
    try {
      // Fetch the donation form from Firestore
      DocumentSnapshot<Map<String, dynamic>> donationFormSnapshot = await firebaseService.getFormById(documentId);
      
      if (donationFormSnapshot.exists) {
        // Update the status to "completed"
        await firebaseService.updateForm(documentId, {
          'status': 3, // update status 
        });
        
        // Notify user or handle success as needed
        print('Donation form status updated successfully');
      } else {
        // Document not found, handle accordingly
        print('Donation form not found');
      }
    } catch (e) {
      // Handle errors
      print('Error updating donation form status: $e');
    }
  }
}


// organization_provider.dart
import 'package:flutter/material.dart';
import 'organizational_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrganizationProvider with ChangeNotifier {
  Organization _organization = Organization(
    name: 'Empowerment for All',
    about: 'Our mission is to break the cycle of poverty by addressing its root causes and equipping individuals with the tools and opportunities they need to achieve economic self-sufficiency. We believe in a holistic approach to development that encompasses education, healthcare, livelihood training, and community empowerment.',
    donationsOpen: true,
  );

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Organization get organization => _organization;

  // Update organization name
  void updateName(String newName) {
    _organization = Organization(
      name: newName,
      about: _organization.about,
      donationsOpen: _organization.donationsOpen,
    );
    notifyListeners();
    _updateOrganizationInFirebase();
  }

  // Update about organization
  void updateAbout(String newAbout) {
    _organization = Organization(
      name: _organization.name,
      about: newAbout,
      donationsOpen: _organization.donationsOpen,
    );
    notifyListeners();
    _updateOrganizationInFirebase();
  }

  // Update donations status
  void updateDonationsStatus(bool isOpen) {
    _organization = Organization(
      name: _organization.name,
      about: _organization.about,
      donationsOpen: isOpen,
    );
    notifyListeners();
    _updateOrganizationInFirebase();
  }

  // Update organization details in Firebase
  Future<void> _updateOrganizationInFirebase() async {
    try {
      await _firestore.collection('organizations').doc('organizationId').set({
        'name': _organization.name,
        'about': _organization.about,
        'donationsOpen': _organization.donationsOpen,
      });
      print('Organization updated successfully in Firebase');
    } catch (e) {
      print('Error updating organization in Firebase: $e');
    }
  }
}

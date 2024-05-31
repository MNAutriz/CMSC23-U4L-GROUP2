// organization_provider.dart
import 'package:flutter/material.dart';
import 'organizational_model.dart';

class OrganizationProvider with ChangeNotifier {
  Organization _organization = Organization(
    name: 'Empowerment for All',
    about:
        'Our mission is to break the cycle of poverty by addressing its root causes and equipping individuals with the tools and opportunities they need to achieve economic self-sufficiency. We believe in a holistic approach to development that encompasses education, healthcare, livelihood training, and community empowerment.',
    donationsOpen: true, // Set to true or false based on donations status
  );

  Organization get organization => _organization;

  get orgCollection => null;

  // Update organization name
  void updateName(String newName) {
    _organization = Organization(
      name: newName,
      about: _organization.about,
      donationsOpen: _organization.donationsOpen,
    );
    notifyListeners();
  }

  // Update about organization
  void updateAbout(String newAbout) {
    _organization = Organization(
      name: _organization.name,
      about: newAbout,
      donationsOpen: _organization.donationsOpen,
    );
    notifyListeners();
  }

  // Update donations status
  void updateDonationsStatus(bool isOpen) {
    _organization = Organization(
      name: _organization.name,
      about: _organization.about,
      donationsOpen: isOpen,
    );
    notifyListeners();
  }
}

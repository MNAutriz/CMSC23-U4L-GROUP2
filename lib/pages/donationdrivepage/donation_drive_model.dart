import '../homepage/donation_model.dart';

/// Model class representing a donation drive.
class DonationDrive {
  /// Unique identifier for the donation drive.
  String id;
  /// Title of the donation drive.
  String title;
  /// Description of the donation drive.
  String description;
  /// URL of the cover photo for the donation drive.
  String coverPhoto;
  /// List of URLs as proof of donations.
  List<String> donationProofs;
  /// List of donations associated with the donation drive.
  List<Donation> donations;
  /// Email of the organization managing the donation drive.
  String orgEmail;

  /// Constructor for DonationDrive which initializes all the properties.
  DonationDrive({
    required this.id,
    required this.title,
    required this.description,
    required this.coverPhoto,
    required this.donationProofs,
    required this.donations,
    required this.orgEmail,
  });

  /// Converts the DonationDrive object into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'coverPhoto': coverPhoto,
      'donationProofs': donationProofs,
      'donations': donations.map((donation) => donation.toJson()).toList(),
      'orgEmail': orgEmail,
    };
  }

  /// Factory constructor to create a DonationDrive object from a JSON map.
  factory DonationDrive.fromJson(Map<String, dynamic> json) {
    return DonationDrive(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      coverPhoto: json['coverPhoto'] ?? '',
      donationProofs: List<String>.from(json['donationProofs'] ?? []),
      donations: List<Donation>.from(json['donations']?.map((donation) => Donation.fromJson(donation)) ?? []),
      orgEmail: json['orgEmail'] ?? '',
    );
  }
}

import '../homepage/donation_model.dart';

class DonationDrive {
  String id;
  String title;
  String description;
  String coverPhoto; // Updated property name
  List<String> donationProofs; // Updated property name
  List<Donation> donations;
  String orgEmail;

  DonationDrive({
    required this.id,
    required this.title,
    required this.description,
    required this.coverPhoto,
    required this.donationProofs,
    required this.donations,
    required this.orgEmail,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'coverPhoto': coverPhoto, // Updated property name
      'donationProofs': donationProofs, // Updated property name
      'donations': donations.map((donation) => donation.toJson()).toList(),
      'orgEmail': orgEmail,
    };
  }

  factory DonationDrive.fromJson(Map<String, dynamic> json) {
    return DonationDrive(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      coverPhoto: json['coverPhoto'], // Updated property name
      donationProofs: List<String>.from(json['donationProofs']), // Updated property name
      donations: List<Donation>.from(json['donations'].map((donation) => Donation.fromJson(donation))),
      orgEmail: json['orgEmail'],
    );
  }
}

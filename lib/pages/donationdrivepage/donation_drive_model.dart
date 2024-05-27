import '../homepage/donation_model.dart';

class DonationDrive {
  String id;
  String title;
  String description;
  List<String> imageUrls;
  List<Donation> donations;

  DonationDrive({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.donations,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrls': imageUrls,
      'donations': donations.map((donation) => donation.toJson()).toList(),
    };
  }

  factory DonationDrive.fromJson(Map<String, dynamic> json) {
    return DonationDrive(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrls: List<String>.from(json['imageUrls']),
      donations: List<Donation>.from(json['donations'].map((donation) => Donation.fromJson(donation))),
    );
  }
}

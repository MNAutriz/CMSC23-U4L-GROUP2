import '../homepage/donation_model.dart';

class DonationDrive {
  final String id;
  final String title;
  final String description;
  final List<String> imageUrls;
  final List<Donation> donations;

  DonationDrive({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.donations,
  });
}

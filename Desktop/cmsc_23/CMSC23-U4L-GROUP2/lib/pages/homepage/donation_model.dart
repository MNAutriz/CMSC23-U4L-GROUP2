class Donation {
  final String title;
  final String description;
  final String imageUrl;
  final double amountRaised;
  final double goal;
  final String? driveDetails; // Optional field for donation drive details
  String status;

  Donation({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.amountRaised,
    required this.goal,
    this.driveDetails,
    this.status = 'Pending',
  });
}

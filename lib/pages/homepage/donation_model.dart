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

  // Convert a Donation into a Map.
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'amountRaised': amountRaised,
      'goal': goal,
      'driveDetails': driveDetails,
      'status': status,
    };
  }

  // Convert a Map into a Donation.
  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      amountRaised: json['amountRaised'],
      goal: json['goal'],
      driveDetails: json['driveDetails'],
      status: json['status'],
    );
  }
}

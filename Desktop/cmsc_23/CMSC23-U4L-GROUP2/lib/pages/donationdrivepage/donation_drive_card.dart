import 'package:flutter/material.dart';
import 'donation_drive_details.dart';
import '../donationpage/donation_page.dart';
import '../homepage/donation_model.dart';

class DonationDriveCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final List<Donation> donations;

  DonationDriveCard({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.donations,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DonationPage(donations: donations, driveTitle: title),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              imageUrl,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

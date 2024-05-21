import 'package:flutter/material.dart';
import 'donation_drive_details.dart';

class DonationDriveCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final double raisedAmount;
  final double goalAmount;

  DonationDriveCard({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.raisedAmount,
    required this.goalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DonationDriveDetails(
              title: title,
              description: description,
              imageUrls: [
                imageUrl,
                'https://via.placeholder.com/150',
                'https://via.placeholder.com/150',
              ], // Add more image URLs
              raisedAmount: raisedAmount,
              goalAmount: goalAmount,
            ),
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
                  SizedBox(height: 10),
                  Text(
                    '\$${raisedAmount.toStringAsFixed(2)} raised of \$${goalAmount.toStringAsFixed(2)} goal',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
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

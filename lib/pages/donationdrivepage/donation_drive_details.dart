import 'package:flutter/material.dart';
import 'donation_drive_model.dart';

class DonationDriveDetailsPage extends StatelessWidget {
  final DonationDrive donationDrive;

  DonationDriveDetailsPage({required this.donationDrive});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(donationDrive.title),
        backgroundColor: Color(0xFF093731),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              donationDrive.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              donationDrive.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Donations:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: donationDrive.donations.length,
                itemBuilder: (context, index) {
                  final donation = donationDrive.donations[index];
                  return ListTile(
                    title: Text(donation.title),
                    subtitle: Text(donation.description),
                    trailing: Text('\$${donation.amountRaised} / \$${donation.goal}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

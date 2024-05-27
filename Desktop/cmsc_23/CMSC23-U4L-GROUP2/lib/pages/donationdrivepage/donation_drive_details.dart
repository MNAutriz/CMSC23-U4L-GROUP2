import 'package:flutter/material.dart';
import 'donation_drive_model.dart';
import '../donationpage/donation_page.dart';

class DonationDriveDetails extends StatelessWidget {
  final DonationDrive donationDrive;

  DonationDriveDetails({required this.donationDrive});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(donationDrive.title),
        backgroundColor: Color(0xFF093731),
      ),
      backgroundColor: Color(0xFFF7F7F7),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
                'Proof of Donations:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: donationDrive.imageUrls.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    donationDrive.imageUrls[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                'Linked Donations:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: donationDrive.donations.length,
                itemBuilder: (context, index) {
                  final donation = donationDrive.donations[index];
                  return ListTile(
                    title: Text(donation.title),
                    subtitle: Text(donation.description),
                    trailing: Text('\$${donation.amountRaised.toStringAsFixed(2)} raised'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

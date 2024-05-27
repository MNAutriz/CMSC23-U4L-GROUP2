import '../../providers/donation_drive_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cmsc23project/providers/donation_drive_provider.dart' as provider;
import 'donation_drive_model.dart';
import 'edit_donation_drive_page.dart';
import 'donation_drive_details.dart';

// builder for a Donation Drive card
class DonationDriveCard extends StatelessWidget {
  final DonationDrive donationDrive;

  DonationDriveCard({required this.donationDrive});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            donationDrive.imageUrls.isNotEmpty ? donationDrive.imageUrls[0] : 'https://via.placeholder.com/150',
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  donationDrive.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  donationDrive.description,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DonationDriveDetailsPage(donationDrive: donationDrive),
                          ),
                        );
                      },
                      child: Text('See details'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditDonationDrivePage(donationDrive: donationDrive),
                          ),
                        );
                      },
                      child: Text('Edit'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<DonationDriveProvider>(context, listen: false)
                            .deleteDonationDrive(donationDrive.id);
                      },
                      child: Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

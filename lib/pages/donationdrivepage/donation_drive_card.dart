import '../../providers/donation_drive_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cmsc23project/providers/donation_drive_provider.dart' as provider;
import '../donationdrivepage/donation_drive_model.dart';
import 'edit_donation_drive_page.dart';
import 'donation_drive_details.dart';

// template for a donation drive card in org view
class DonationDriveCard extends StatelessWidget {
  final DonationDrive donationDrive;
  final String orgEmail;

  DonationDriveCard({required this.donationDrive, required this.orgEmail});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 4,
      color: Colors.white, // Set the background color to white
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            donationDrive.coverPhoto.isNotEmpty ? donationDrive.coverPhoto : 'https://via.placeholder.com/150',
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  donationDrive.title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  donationDrive.description,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DonationDriveDetailsPage(donationDrive: donationDrive, orgEmail: orgEmail,),
                          ),
                        );
                      },
                      child: const Text('See details'),
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
                      child: const Text('Edit'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<DonationDriveProvider>(context, listen: false)
                            .deleteDonationDrive(donationDrive.id);
                      },
                      child: const Text('Delete'),
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

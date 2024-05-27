import 'package:cmsc23project/pages/donationdrivepage/add_donation_drive_page.dart';
import 'package:cmsc23project/providers/donation_drive_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationDrivesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final donationDrives = Provider.of<DonationDriveProvider>(context).donationDrives;

    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Drives Page'),
        backgroundColor: Color(0xFF093731),
      ),
      body: ListView.builder(
        itemCount: donationDrives.length,
        itemBuilder: (context, index) {
          final drive = donationDrives[index];
          return ListTile(
            title: Text(drive.title),
            subtitle: Text(drive.description),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDonationDrivePage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF093731),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/models/organization_model.dart';
import 'package:cmsc23project/pages/adminpage/viewdonationdrive.dart';
import 'package:cmsc23project/providers/donation_drive_provider.dart';
import 'package:cmsc23project/providers/donor_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrganizationDrives extends StatefulWidget {
  final Organization organization;

  const OrganizationDrives({super.key, required this.organization});

  @override
  State<OrganizationDrives> createState() => _OrganizationDrivesState();
}

class _OrganizationDrivesState extends State<OrganizationDrives> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> drivesStream =
        context.watch<DonationDriveProvider>().drivesStream;

    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E6),
      appBar: AppBar(
        title: Text(
          "Donation Drives",
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1C6758),
        foregroundColor: const Color(0xFFEEF2E6),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: drivesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error encountered! ${snapshot.error}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
            //no data yet
          } else if (!snapshot.hasData) {
            return emptyDonationDrives();
            //empty donors database
          } else if (snapshot.data!.docs
              .where((doc) => doc['orgEmail'] == widget.organization.email)
              .isEmpty) {
            //empty donors database
            return emptyDonationDrives();
          }

          // filter donors where donorEmail is the same as donor email
          var docs = snapshot.data!.docs
              .where((doc) => doc['orgEmail'] == widget.organization.email)
              .toList();

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var donationDrive = docs[index].data() as Map<String, dynamic>;

              return Card(
                //list tile of each donor
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewDonationDrive(
                                donationDrive: donationDrive)));
                  },
                  leading: const Icon(Icons.waving_hand),
                  title: Text("Donation Drive: ${donationDrive['title']}"),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget emptyDonationDrives() {
    return const Center(
      child: Text("No donation drives yet."),
    );
  }
}

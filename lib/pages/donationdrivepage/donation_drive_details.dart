import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/providers/donor_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'donation_drive_model.dart';

/// A stateless widget that displays detailed information about a specific donation drive.
/// It also streams and displays donor forms associated with the donation drive.
class DonationDriveDetailsPage extends StatelessWidget {
  final DonationDrive donationDrive;
  final String orgEmail;

  /// Constructor for DonationDriveDetailsPage which takes a donation drive and organization email as parameters.
  DonationDriveDetailsPage({required this.donationDrive, required this.orgEmail});

  @override
  Widget build(BuildContext context) {
    // Stream of donor forms from the DonorFormProvider.
    Stream<QuerySnapshot> _formsStream = context.watch<DonorFormProvider>().formsStream;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Donation Drive Info"),
      ),
      body: Column(
        children: [
          Column(
            children: [
              // Display the title of the donation drive.
              Text(donationDrive.title),
              // Display the description of the donation drive.
              Text(donationDrive.description),
              const Text("FORMS:"),
            ],
          ),
          Expanded(
            child: StreamBuilder(
              stream: _formsStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error encountered! ${snapshot.error}"));
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No donation drives in collection."));
                }

                // Filter forms that have the same donationDriveId.
                final docs = snapshot.data!.docs.where((doc) => doc['donationDriveId'] == donationDrive.id).toList();

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final formData = docs[index].data() as Map<String, dynamic>;
                    return Card(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: () {
                          // TODO: Create form info page (can update status inside this page)
                        },
                        child: Column(
                          children: [
                            // Display the document ID.
                            Text(docs[index].id),
                            // Display the donation types from the form data.
                            Text(formData['donationTypes'].toString()),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

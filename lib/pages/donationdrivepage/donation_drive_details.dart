import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:cmsc23project/pages/donationdrivepage/donation_drive_model.dart';
import 'package:cmsc23project/providers/donor_form_provider.dart';
import 'package:cmsc23project/models/donor_form.dart';
import 'package:cmsc23project/pages/donationdrivepage/form_details_page/form_details.dart';

class DonationDriveDetailsPage extends StatelessWidget {
  final DonationDrive donationDrive;
  final String orgEmail;

  DonationDriveDetailsPage(
      {required this.donationDrive, required this.orgEmail});

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _formsStream =
        context.watch<DonorFormProvider>().formsStream;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Donation Drive Info",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF093731),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFEEF2E6),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Header(text: donationDrive.title),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                donationDrive.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Donor Donations:",
              style: TextStyle(
                color: Color(0xFF1C6758),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            StreamBuilder(
              stream: _formsStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error encountered! ${snapshot.error}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      "No donation drives in collection.",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }

                final docs = snapshot.data!.docs
                    .where((doc) => doc['donationDriveId'] == donationDrive.id)
                    .toList();

                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final formData = docs[index].data() as Map<String, dynamic>;
                    return Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FormDetailsPage(formData: formData),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(
                            "Donation by: ${formData['donorEmail']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(
                                  0xFF1C6758), // Change color to match the header
                            ),
                            textAlign: TextAlign.center,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5), // Add some spacing
                              Text(
                                "ID: ${docs[index].id}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5), // Add some spacing
                              Text(
                                "Donation Types: ${formData['donationTypes'].toString()}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 5), // Add some spacing
                              Text(
                                "Pickup: ${formData['forPickup'] ? 'Yes' : 'No'}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 5), // Add some spacing
                              Text(
                                "Status: ${getStatusString(formData['status'])}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: getStatusColor(formData['status']),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          trailing: PopupMenuButton<int>(
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 0,
                                child: Text('Pending'),
                              ),
                              const PopupMenuItem(
                                value: 1,
                                child: Text('Confirmed'),
                              ),
                              const PopupMenuItem(
                                value: 2,
                                child: Text('Scheduled for Pickup'),
                              ),
                              const PopupMenuItem(
                                value: 3,
                                child: Text('Complete'),
                              ),
                              const PopupMenuItem(
                                value: 4,
                                child: Text('Cancelled'),
                              ),
                            ],
                            onSelected: (value) {
                              formData['status'] = value;
                              context
                                  .read<DonorFormProvider>()
                                  .updateForm(docs[index].id, formData);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String getStatusString(int status) {
    switch (status) {
      case 0:
        return 'Pending';
      case 1:
        return 'Confirmed';
      case 2:
        return 'Scheduled for Pickup';
      case 3:
        return 'Complete';
      case 4:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  Color getStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.orange;
      case 1:
        return Colors.blue;
      case 2:
        return Colors.purple;
      case 3:
        return Colors.green;
      case 4:
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}

class Header extends StatelessWidget {
  final String text;

  const Header({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFF093731),
            borderRadius: BorderRadius.circular(100)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFFEEF2E6)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

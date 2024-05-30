import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/models/donor_form.dart';
import 'package:cmsc23project/pages/donationdrivepage/form_details_page/form_details.dart';
import 'package:cmsc23project/providers/donor_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'donation_drive_model.dart';

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
      appBar: AppBar(title: const Text("Donation Drive Info")),
      backgroundColor: const Color(0xFFEEF2E6),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  donationDrive.title,
                  style: const TextStyle(
                    color: Color(0xFF1C6758),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  donationDrive.description,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              const Text("Donations:")
            ],
          ),
          Expanded(
            child: StreamBuilder(
              stream: _formsStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text("Error encountered! ${snapshot.error}"));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                      child: Text("No donation drives in collection."));
                }

                final docs = snapshot.data!.docs
                    .where((doc) => doc['donationDriveId'] == donationDrive.id)
                    .toList();

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final formData = docs[index].data() as Map<String, dynamic>;
                    return Card(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormDetailsPage(
                                formData: formData,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Donation by: ${formData['donorEmail']}",
                                style: const TextStyle(
                                  color: Color(0xFF1C6758),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Id: ${docs[index].id}",
                                    style: const TextStyle(
                                      color: Color(0xFF1C6758),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(formData['donationTypes'].toString()),
                                  Text(
                                    "Status: ${getStatusString(formData['status'])}",
                                    style: TextStyle(
                                      color: getStatusColor(formData['status']),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
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
                                  context.read<DonorFormProvider>().updateForm(docs[index].id, formData);
                                },
                              ),
                            ),
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

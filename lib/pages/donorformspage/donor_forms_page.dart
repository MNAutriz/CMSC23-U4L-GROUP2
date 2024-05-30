import 'package:cmsc23project/models/donor_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:cmsc23project/providers/donor_form_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class DonorFormsPage extends StatefulWidget {
  const DonorFormsPage({super.key});

  @override
  State<DonorFormsPage> createState() => _DonorFormsPageState();
}

class _DonorFormsPageState extends State<DonorFormsPage> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> formsStream =
        context.watch<DonorFormProvider>().formsStream;
    User? user = context.watch<UserAuthProvider>().user;

    final donorFormProvider = Provider.of<DonorFormProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Submitted Forms",
            style: TextStyle(
                color: Color(0xFFEEF2E6), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF093731),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: formsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error encountered! ${snapshot.error}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return emptyForms();
          }

          // filter forms where donorEmail is the same as logged in email
          var docs = snapshot.data!.docs
              .where((doc) => doc['donorEmail'] == user!.email)
              .toList();

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var form = docs[index].data() as Map<String, dynamic>;
              var formId = docs[index].id;

              return Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0), // Adjust padding here
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        color: Colors.green[100],
                        child: InkWell(
                          onTap: () {
                            // show form information
                            // TODO: create page to show form info
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${form['orgName']}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Color(0xFF093731))),
                                Text("${form['donationDriveName']}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Color(0xFF093731))),
                                Text(
                                    "Donation Drive Id: ${form['donationDriveId']}"),
                                // Text("Donation Drive Name: ${form['donationDriveName']}"),
                                Text("Id: $formId"),
                                Text(
                                    "Donation Types: ${form['donationTypes'].join(", ")}"), // .join() concatenates elements into a single string with a separator
                                Text(
                                    "Status: ${getStatusString(form['status'] ?? -1)}",
                                    style: TextStyle(
                                        color: getStatusColor(
                                            form['status'] ?? -1),
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            15)), // if null status, return -1
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: form['status'] != 4,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        color: Colors.red,
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () {
                            // Show confirmation dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: const Color(0xFF093731),
                                  title: const Text("Confirmation",
                                      style:
                                          TextStyle(color: Color(0xFFEEF2E6))),
                                  content: const Text(
                                      "Are you sure you want to cancel?",
                                      style:
                                          TextStyle(color: Color(0xFFEEF2E6))),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        // Close the dialog
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("No",
                                          style: TextStyle(
                                              color: Color(0xFFEEF2E6))),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // update form status to cancelled
                                        if (form['status'] == 0) {
                                          form['status'] = 4;
                                          donorFormProvider.updateForm(formId,
                                              form); // pass updated form back to provider
                                        }
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Yes",
                                          style: TextStyle(
                                              color: Color(0xFFEEF2E6))),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                                child: Text("Cancel",
                                    style: TextStyle(
                                        color: Color(0xFFEEF2E6),
                                        fontWeight: FontWeight.bold))),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget emptyForms() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("No donations submitted yet.",
              style: TextStyle(fontSize: 15, color: Color(0xFF093731))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/donor', (route) => false);
                // Navigator.pushNamed(context, '/donor');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFFEEF2E6),
                backgroundColor: const Color(0xFF093731), // text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // rounded corners
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 16, horizontal: 32), // padding
              ),
              child: const Text(
                "DONATE NOW!",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
        return 'Unknown'; // Handle any other status value
    }
  }

  // sample colors for donation status
  Color getStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.orange; // Pending
      case 1:
        return Colors.blue; // Confirmed
      case 2:
        return Colors.purple; // Scheduled for Pickup
      case 3:
        return Colors.green; // Complete
      case 4:
        return Colors.red; // Cancelled
      default:
        return Colors.black; // Unknown status
    }
  }
}

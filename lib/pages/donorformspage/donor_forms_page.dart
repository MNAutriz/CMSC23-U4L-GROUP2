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
        title: const Text("My Submitted Forms", style: TextStyle(color: Color(0xFFEEF2E6), fontWeight: FontWeight.bold)),
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
          var docs = snapshot.data!.docs.where((doc) => doc['donorEmail'] == user!.email).toList();

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var form = docs[index].data() as Map<String, dynamic>;
              var formId = docs[index].id;

              return Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Adjust padding here
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        color: Colors.green[100],
                        child: InkWell(
                          onTap: () {
                            // show form information
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Donation to ${form['orgName']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFFEEF2E6))),
                                Text("Id: $formId"),
                                Text("Donation Types: ${form['donationTypes'].join(", ")}"), // .join() concatenates elements into a single string with a separator
                                Text("Status: ${getStatusString(form['status'] ?? -1)}", style: TextStyle(color: getStatusColor(form['status'] ?? -1), fontWeight: FontWeight.bold, fontSize: 15)), // if null status, return -1
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
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
                                title: Text("Confirmation", style: TextStyle(color: Color(0xFFEEF2E6))),
                                content: Text("Are you sure you want to cancel?", style: TextStyle(color: Color(0xFFEEF2E6))),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // Close the dialog
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("No", style: TextStyle(color: Color(0xFFEEF2E6))),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // delete form
                                      if(form['status'] != 1){
                                        donorFormProvider.deleteForm(formId);
                                      }
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Yes", style: TextStyle(color: Color(0xFFEEF2E6))),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(child: Text("Cancel", style: TextStyle(color: Color(0xFFEEF2E6), fontWeight: FontWeight.bold))),
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
    return const Center(
      child: Text("No submitted forms yet."),
    );
  }

  String getStatusString(int status) {
    switch (status) {
      case 0:
        return 'Pending';
      case 1:
        return 'Confirmed';
      case 2:
        return 'Active';
      case 3:
        return 'Inactive';
      case 4:
        return 'Suspended';
      case 5:
        return 'Banned';
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
        return Colors.green; // Active
      case 3:
        return Colors.grey; // Inactive
      case 4:
        return Colors.yellow; // Suspended
      case 5:
        return Colors.red; // Banned
      default:
        return Colors.black; // Unknown status
    }
  }
}

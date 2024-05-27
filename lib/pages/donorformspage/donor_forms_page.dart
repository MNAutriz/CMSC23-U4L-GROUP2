import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:cmsc23project/providers/donor_form_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonorFormsPage extends StatefulWidget {
  const DonorFormsPage({super.key});

  @override
  State<DonorFormsPage> createState() => _DonorFormsPageState();
}

class _DonorFormsPageState extends State<DonorFormsPage> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> formsStream = context.watch<DonorFormProvider>().formsStream;
    User? user = context.watch<UserAuthProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Submitted Forms"),
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

              return Card(
                margin: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Form ID: $formId"),
                      const SizedBox(height: 5),
                      Text("Donation Types: ${form['donationTypes'].join(', ')}",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Text("Date and Time: ${form['donationDateTime']}",
                          style: const TextStyle(fontSize: 14)),
                      const SizedBox(height: 5),
                      Text("Weight: ${form['weight']} ${form['weightUnit']}",
                          style: const TextStyle(fontSize: 14)),
                      const SizedBox(height: 5),
                      Text("For Pickup: ${form['forPickup'] ? 'Yes' : 'No'}",
                          style: const TextStyle(fontSize: 14)),
                      const SizedBox(height: 5),
                      form['forPickup']
                          ? Text("Pickup Address: ${form['pickupAddresses'] ?? 'N/A'}",
                              style: const TextStyle(fontSize: 14))
                          : Container(),
                      const SizedBox(height: 5),
                      Text("Contact No: ${form['contactNo'] ?? 'N/A'}",
                          style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
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
}

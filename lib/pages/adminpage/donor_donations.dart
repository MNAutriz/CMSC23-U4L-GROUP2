import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/models/donor_model.dart';
import 'package:cmsc23project/pages/adminpage/viewdonation.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:cmsc23project/providers/donor_form_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonorDonations extends StatefulWidget {
  final Donor donor;
  const DonorDonations({super.key, required this.donor});

  @override
  State<DonorDonations> createState() => _DonorDonationsState();
}

class _DonorDonationsState extends State<DonorDonations> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> formsStream =
        context.watch<DonorFormProvider>().formsStream;

    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E6),
      appBar: AppBar(
        title: Text(
          "Donation History",
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1C6758),
        foregroundColor: const Color(0xFFEEF2E6),
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
            //no data yet
          } else if (!snapshot.hasData) {
            return emptyDonations();
            //empty donors database
          } else if (snapshot.data!.docs
              .where((doc) => doc['donorEmail'] == widget.donor.email)
              .isEmpty) {
            //empty donors database
            return emptyDonations();
          }

          // filter donors where donorEmail is the same as donor email
          var docs = snapshot.data!.docs
              .where((doc) => doc['donorEmail'] == widget.donor.email)
              .toList();

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var form = docs[index].data() as Map<String, dynamic>;

              return Card(
                //list tile of each donor
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewDonation(form: form)));
                  },
                  leading: const Icon(Icons.person),
                  title: Text("Donation Drive: ${form['donationDriveName']}"),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget emptyDonations() {
    return const Center(
      child: Text("No donations yet."),
    );
  }
}

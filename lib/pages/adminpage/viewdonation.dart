import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:cmsc23project/providers/donor_form_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewDonation extends StatefulWidget {
  //donor form instance
  final Map<String, dynamic> form;
  const ViewDonation({super.key, required this.form});

  @override
  State<ViewDonation> createState() => _DonorDonationsState();
}

class _DonorDonationsState extends State<ViewDonation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFEEF2E6),
        appBar: AppBar(
          title: Text(
            "Donation Details",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF1C6758),
          foregroundColor: const Color(0xFFEEF2E6),
        ),

        //details of friend
        body: details());
  }

  //details widget
  Widget details() {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Donation Drive: ${widget.form['donationDriveName']}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text("Organization: ${widget.form['orgName']}",
                  style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 5),
              Text("Donation Types: ${widget.form['donationTypes'].join(', ')}",
                  style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 5),
              Text("Date and Time: ${widget.form['donationDateTime']}",
                  style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 5),
              Text(
                  "Weight: ${widget.form['weight']} ${widget.form['weightUnit']}",
                  style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 5),
              Text("For Pickup: ${widget.form['forPickup'] ? 'Yes' : 'No'}",
                  style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 5),
              widget.form['forPickup']
                  ? Text(
                      "Pickup Address: ${widget.form['pickupAddresses'] ?? 'N/A'}",
                      style: const TextStyle(fontSize: 14))
                  : Container(),
              const SizedBox(height: 5),
              Text("Contact No: ${widget.form['contactNo'] ?? 'N/A'}",
                  style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}

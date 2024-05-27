import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:cmsc23project/providers/organization_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../donationdrivepage/donation_drive_model.dart';
import '../../providers/donation_drive_provider.dart';
import '../homepage/donation_model.dart';

class AddDonationDrivePage extends StatefulWidget {
  @override
  _AddDonationDrivePageState createState() => _AddDonationDrivePageState();
}

// form page that adds a donation drive
class _AddDonationDrivePageState extends State<AddDonationDrivePage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _coverPhotoUrl = '';
  List<String> _proofOfDonationsUrls = [];
  List<Donation> _donations = [];

  String organizationEmail = ''; // store organization email that is fetched from firebase and matched with organizations collection

  @override
  Widget build(BuildContext context) {
    
    final donationDriveProvider = Provider.of<DonationDriveProvider>(context);

    User? user = context.watch<UserAuthProvider>().user;
    organizationEmail = user!.email!; // assign logged in user as the organizationEmail

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Donation Drive'),
        backgroundColor: Color(0xFF093731),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Cover Photo URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a cover photo URL';
                  }
                  return null;
                },
                onSaved: (value) {
                  _coverPhotoUrl = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Proof of Donations URLs (comma separated)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter at least one proof of donations URL';
                  }
                  return null;
                },
                onSaved: (value) {
                  _proofOfDonationsUrls = value!.split(',').map((url) => url.trim()).toList();
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    DonationDrive newDonationDrive = DonationDrive(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: _title,
                      description: _description,
                      coverPhoto: _coverPhotoUrl,
                      donationProofs: [..._proofOfDonationsUrls],
                      donations: _donations,
                      orgEmail: organizationEmail
                    );
                    await donationDriveProvider.addDonationDrive(newDonationDrive.toJson()); // convert object to a Map<String, dynamic> before passing to addDonationDrive
                    Navigator.pop(context);
                  }
                },
                child: const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

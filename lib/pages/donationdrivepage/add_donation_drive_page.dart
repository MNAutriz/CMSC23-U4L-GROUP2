import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../donationdrivepage/donation_drive_model.dart';
import '../../providers/donation_drive_provider.dart';
import '../homepage/donation_model.dart';

/// The AddDonationDrivePage class is a stateful widget that represents a page where
/// users can create a new donation drive.
class AddDonationDrivePage extends StatefulWidget {
  
  /// The organization email associated with the donation drive.
  final String orgEmail;
  
  /// Constructor for AddDonationDrivePage which takes an organization email as a required parameter.
  AddDonationDrivePage({super.key, required this.orgEmail});

  @override
  _AddDonationDrivePageState createState() => _AddDonationDrivePageState();
}

class _AddDonationDrivePageState extends State<AddDonationDrivePage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _coverPhotoUrl = '';
  List<String> _proofOfDonationsUrls = [];
  List<Donation> _donations = [];

  final TextEditingController _donationTitleController = TextEditingController();
  final TextEditingController _donationDescriptionController = TextEditingController();
  final TextEditingController _donationImageUrlController = TextEditingController();
  final TextEditingController _donationAmountRaisedController = TextEditingController();
  final TextEditingController _donationGoalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Access the DonationDriveProvider to manage donation drive data.
    final donationDriveProvider = Provider.of<DonationDriveProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Donation Drive'),
        backgroundColor: Color(0xFF093731),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// Form field to input the title of the donation drive.
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
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
                /// Form field to input the description of the donation drive.
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
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
                /// Form field to input the cover photo URL of the donation drive.
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Cover Photo URL'),
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
                /// Form field to input the proof of donations URLs.
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Proof of Donations URLs (comma separated)'),
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
                const SizedBox(height: 20),
                const Text('Add Donations:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                /// Form fields to input details about each donation.
                TextFormField(
                  controller: _donationTitleController,
                  decoration: const InputDecoration(labelText: 'Donation Title'),
                ),
                TextFormField(
                  controller: _donationDescriptionController,
                  decoration: const InputDecoration(labelText: 'Donation Description'),
                ),
                TextFormField(
                  controller: _donationImageUrlController,
                  decoration: const InputDecoration(labelText: 'Donation Image URL'),
                ),
                TextFormField(
                  controller: _donationAmountRaisedController,
                  decoration: const InputDecoration(labelText: 'Amount Raised'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: _donationGoalController,
                  decoration: const InputDecoration(labelText: 'Goal Amount'),
                  keyboardType: TextInputType.number,
                ),
                /// Button to add a donation to the list of donations.
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _donations.add(Donation(
                        title: _donationTitleController.text,
                        description: _donationDescriptionController.text,
                        imageUrl: _donationImageUrlController.text,
                        amountRaised: double.parse(_donationAmountRaisedController.text),
                        goal: double.parse(_donationGoalController.text),
                      ));
                      _donationTitleController.clear();
                      _donationDescriptionController.clear();
                      _donationImageUrlController.clear();
                      _donationAmountRaisedController.clear();
                      _donationGoalController.clear();
                    });
                  },
                  child: const Text('Add Donation'),
                ),
                const SizedBox(height: 20),
                /// Button to create a new donation drive.
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
                        orgEmail: widget.orgEmail, // replace with actual email
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
      ),
    );
  }
}

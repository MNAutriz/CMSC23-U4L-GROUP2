import 'package:cmsc23project/pages/homepage/donation_model.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../donationdrivepage/donation_drive_model.dart';
import '../../providers/donation_drive_provider.dart';

/// A stateful widget that allows users to edit an existing donation drive.
class EditDonationDrivePage extends StatefulWidget {
  final DonationDrive donationDrive;

  /// Constructor for EditDonationDrivePage which takes a donation drive as a parameter.
  EditDonationDrivePage({required this.donationDrive});

  @override
  _EditDonationDrivePageState createState() => _EditDonationDrivePageState();
}

class _EditDonationDrivePageState extends State<EditDonationDrivePage> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late String _coverPhotoUrl;
  late List<String> _proofOfDonationsUrls;
  late List<Donation> _donations;

  final TextEditingController _donationTitleController = TextEditingController();
  final TextEditingController _donationDescriptionController = TextEditingController();
  final TextEditingController _donationImageUrlController = TextEditingController();
  final TextEditingController _donationAmountRaisedController = TextEditingController();
  final TextEditingController _donationGoalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _title = widget.donationDrive.title;
    _description = widget.donationDrive.description;
    _coverPhotoUrl = widget.donationDrive.coverPhoto;
    _proofOfDonationsUrls = widget.donationDrive.donationProofs;
    _donations = widget.donationDrive.donations;
  }

  @override
  Widget build(BuildContext context) {
    final donationDriveProvider = Provider.of<DonationDriveProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Donation Drive'),
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
                  initialValue: _title,
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
                /// Form field to input the description of the donation drive.
                TextFormField(
                  initialValue: _description,
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
                /// Form field to input the cover photo URL of the donation drive.
                TextFormField(
                  initialValue: _coverPhotoUrl,
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
                  initialValue: _proofOfDonationsUrls.join(', '),
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
                SizedBox(height: 20),
                Text('Add Donations:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                /// Form fields to input details about each donation.
                TextFormField(
                  controller: _donationTitleController,
                  decoration: InputDecoration(labelText: 'Donation Title'),
                ),
                TextFormField(
                  controller: _donationDescriptionController,
                  decoration: InputDecoration(labelText: 'Donation Description'),
                ),
                TextFormField(
                  controller: _donationImageUrlController,
                  decoration: InputDecoration(labelText: 'Donation Image URL'),
                ),
                TextFormField(
                  controller: _donationAmountRaisedController,
                  decoration: InputDecoration(labelText: 'Amount Raised'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: _donationGoalController,
                  decoration: InputDecoration(labelText: 'Goal Amount'),
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
                  child: Text('Add Donation'),
                ),
                SizedBox(height: 20),
                /// Button to save changes and update the donation drive.
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final updatedDrive = DonationDrive(
                        id: widget.donationDrive.id,
                        title: _title,
                        description: _description,
                        coverPhoto: _coverPhotoUrl,
                        donationProofs: _proofOfDonationsUrls,
                        donations: _donations,
                        orgEmail: widget.donationDrive.orgEmail,
                      );
                      donationDriveProvider.editDonationDrive(updatedDrive.id, updatedDrive.toJson());
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

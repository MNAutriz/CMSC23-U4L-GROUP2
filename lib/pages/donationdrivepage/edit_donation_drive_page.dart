import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../donationdrivepage/donation_drive_model.dart';
import '../../providers/donation_drive_provider.dart';

class EditDonationDrivePage extends StatefulWidget {
  final DonationDrive donationDrive;

  EditDonationDrivePage({required this.donationDrive});

  @override
  _EditDonationDrivePageState createState() => _EditDonationDrivePageState();
}

class _EditDonationDrivePageState extends State<EditDonationDrivePage> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late String _coverPhoto;
  late List<String> _donationProofs;

  @override
  void initState() {
    super.initState();
    _title = widget.donationDrive.title ?? '';
    _description = widget.donationDrive.description ?? '';
    _coverPhoto = widget.donationDrive.coverPhoto ?? '';
    _donationProofs = widget.donationDrive.donationProofs ?? [];
  }

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<UserAuthProvider>().user;
    String orgEmail = user?.email ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Donation Drive'),
        backgroundColor: Color(0xFF093731),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                  _title = value ?? '';
                },
              ),
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
                  _description = value ?? '';
                },
              ),
              TextFormField(
                initialValue: _coverPhoto,
                decoration: InputDecoration(labelText: 'Cover Photo URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a cover photo URL';
                  }
                  return null;
                },
                onSaved: (value) {
                  _coverPhoto = value ?? '';
                },
              ),
              TextFormField(
                initialValue: _donationProofs.join(', '),
                decoration: InputDecoration(labelText: 'Donation Proof URLs (comma separated)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter at least one donation proof URL';
                  }
                  return null;
                },
                onSaved: (value) {
                  _donationProofs = value?.split(',').map((url) => url.trim()).toList() ?? [];
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final updatedDrive = DonationDrive(
                      id: widget.donationDrive.id,
                      title: _title,
                      description: _description,
                      coverPhoto: _coverPhoto,
                      donationProofs: _donationProofs,
                      donations: widget.donationDrive.donations,
                      orgEmail: orgEmail,
                    );
                    Provider.of<DonationDriveProvider>(context, listen: false).editDonationDrive(updatedDrive.id, updatedDrive.toJson());
                    Navigator.pop(context);
                  }
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

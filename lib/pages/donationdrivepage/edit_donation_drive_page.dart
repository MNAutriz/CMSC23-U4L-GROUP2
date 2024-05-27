import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'donation_drive_model.dart';
import 'donation_drive_provider.dart';
import '../homepage/donation_model.dart';

class EditDonationDrivePage extends StatefulWidget {
  final DonationDrive? donationDrive;

  EditDonationDrivePage({this.donationDrive});

  @override
  _EditDonationDrivePageState createState() => _EditDonationDrivePageState();
}

class _EditDonationDrivePageState extends State<EditDonationDrivePage> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late String _coverPhotoUrl;
  late List<String> _proofOfDonationsUrls;
  List<Donation> _donations = [];

  @override
  void initState() {
    super.initState();
    if (widget.donationDrive != null) {
      _title = widget.donationDrive!.title;
      _description = widget.donationDrive!.description;
      _coverPhotoUrl = widget.donationDrive!.imageUrls.isNotEmpty ? widget.donationDrive!.imageUrls[0] : '';
      _proofOfDonationsUrls = widget.donationDrive!.imageUrls.length > 1
          ? widget.donationDrive!.imageUrls.sublist(1)
          : [];
      _donations = widget.donationDrive!.donations;
    } else {
      _title = '';
      _description = '';
      _coverPhotoUrl = '';
      _proofOfDonationsUrls = [];
      _donations = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.donationDrive == null ? 'Create Donation Drive' : 'Edit Donation Drive'),
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
                  _title = value!;
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
                  _description = value!;
                },
              ),
              TextFormField(
                initialValue: _coverPhotoUrl,
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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final updatedDonationDrive = DonationDrive(
                      id: widget.donationDrive!.id,
                      title: _title,
                      description: _description,
                      imageUrls: [_coverPhotoUrl, ..._proofOfDonationsUrls],
                      donations: _donations,
                    );
                    Provider.of<DonationDriveProvider>(context, listen: false).updateDonationDrive(
                      widget.donationDrive!.id,
                      updatedDonationDrive,
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

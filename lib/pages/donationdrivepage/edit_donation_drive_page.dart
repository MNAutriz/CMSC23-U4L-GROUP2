import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'donation_drive_model.dart';
import '../../providers/donation_drive_provider.dart';
import '../homepage/donation_model.dart';

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
  late List<String> _imageUrls;

  @override
  void initState() {
    super.initState();
    _title = widget.donationDrive.title;
    _description = widget.donationDrive.description;
    _imageUrls = widget.donationDrive.imageUrls;
  }

  @override
  Widget build(BuildContext context) {
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
                initialValue: _imageUrls.join(', '),
                decoration: InputDecoration(labelText: 'Image URLs (comma separated)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter at least one image URL';
                  }
                  return null;
                },
                onSaved: (value) {
                  _imageUrls = value!.split(',').map((url) => url.trim()).toList();
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
                      imageUrls: _imageUrls,
                      donations: widget.donationDrive.donations,
                    );
                    Provider.of<DonationDriveProvider>(context, listen: false).updateDonationDrive(updatedDrive.id, updatedDrive);
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

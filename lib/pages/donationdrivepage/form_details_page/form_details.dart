import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class FormDetailsPage extends StatefulWidget {
  final Map<String, dynamic> formData;

  FormDetailsPage({Key? key, required this.formData}) : super(key: key);

  @override
  _FormDetailsPageState createState() => _FormDetailsPageState();
}

class _FormDetailsPageState extends State<FormDetailsPage> {
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() {
    String? base64String = widget.formData['donationPhoto'];
    if (base64String != null && base64String.isNotEmpty) {
      setState(() {
        _imageBytes = base64Decode(base64String);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextTile('Donation Drive Name', widget.formData['donationDriveName'] ?? 'N/A'),
            _buildTextTile('Donation Types', widget.formData['donationTypes']?.join(', ') ?? 'N/A'),
            _buildTextTile('Donor Email', widget.formData['donorEmail'] ?? 'N/A'),
            _buildTextTile('For Pickup', widget.formData['forPickup'] ? 'Yes' : 'No'),
            _buildTextTile('Organization ID', widget.formData['orgId'] ?? 'N/A'),
            _buildTextTile('Organization Name', widget.formData['orgName'] ?? 'N/A'),
            _buildTextTile('Pickup Addresses', widget.formData['pickupAddresses'] ?? 'N/A'),
            _buildTextTile('Status', getStatusString(widget.formData['status'])),
            _buildTextTile('Weight', '${widget.formData['weight'] ?? ''} ${widget.formData['weightUnit'] ?? ''}'),
            _imageBytes != null
                ? ListTile(
                    title: const Text('Donation Photo'),
                    subtitle: Image.memory(_imageBytes!),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

Widget _buildTextTile(String title, dynamic subtitle) {
  return ListTile(
    title: Text(title),
    subtitle: Text(subtitle is List ? subtitle.join(', ') : subtitle.toString()),
  );
}


  String getStatusString(int? status) {
    switch (status) {
      case 0:
        return 'Pending';
      case 1:
        return 'Confirmed';
      case 2:
        return 'Scheduled for Pickup';
      case 3:
        return 'Complete';
      case 4:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }
}

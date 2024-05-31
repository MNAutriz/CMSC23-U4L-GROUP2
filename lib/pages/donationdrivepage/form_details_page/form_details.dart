import 'dart:convert';
import 'dart:typed_data';
import 'package:cmsc23project/pages/donationdrivepage/qr_scanner/qr_scanner_page.dart';
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
      backgroundColor: const Color(0xFFEEF2E6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF093731),
        iconTheme: const IconThemeData(
          color: Color(0xFFEEF2E6),
        ),
        title: const Text(
          "Form Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFEEF2E6),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(text: "Donation Information"),
            if (!widget.formData['forPickup'])
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD95F2A), // orange medyo
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QrScannerPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Update Status using QR',
                    style: TextStyle(color: Color(0xFFEEF2E6)),
                  ),
                ),
              ),
            _buildTextTile('Donation Drive Name',
                widget.formData['donationDriveName'] ?? 'N/A'),
            _buildTextTile('Donation Types',
                widget.formData['donationTypes']?.join(', ') ?? 'N/A'),
            _buildTextTile(
                'Donor Email', widget.formData['donorEmail'] ?? 'N/A'),
            _buildTextTile(
                'For Pickup', widget.formData['forPickup'] ? 'Yes' : 'No'),
            _buildTextTile(
                'Organization ID', widget.formData['orgId'] ?? 'N/A'),
            _buildTextTile(
                'Organization Name', widget.formData['orgName'] ?? 'N/A'),
            _buildTextTile('Pickup Addresses',
                widget.formData['pickupAddresses']?.join(', ') ?? 'N/A'),
            _buildTextTile(
                'Status', getStatusString(widget.formData['status'])),
            _buildTextTile('Weight',
                '${widget.formData['weight'] ?? ''} ${widget.formData['weightUnit'] ?? ''}'),
            if (_imageBytes != null)
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2E6),
                  border: Border.all(color: const Color(0xFF093731), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Donation Photo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF093731),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Image.memory(_imageBytes!),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextTile(String title, dynamic subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF093731),
          ),
        ),
        subtitle: Text(
          subtitle is List ? subtitle.join(', ') : subtitle.toString(),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ),
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

class Header extends StatelessWidget {
  final String text;

  const Header({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF093731),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFFEEF2E6),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

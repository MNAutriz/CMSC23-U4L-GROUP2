import 'package:flutter/material.dart';

class FormDetailsPage extends StatelessWidget {
  final Map<String, dynamic> formData;

  FormDetailsPage({required this.formData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: const Text('Donation Drive Name'),
              subtitle: Text(formData['donationDriveName'] ?? 'N/A'),
            ),
            ListTile(
              title: const Text('Donation Types'),
              subtitle: Text(formData['donationTypes'].join(', ') ?? 'N/A'),
            ),
            ListTile(
              title: const Text('Donor Email'),
              subtitle: Text(formData['donorEmail'] ?? 'N/A'),
            ),
            ListTile(
              title: const Text('For Pickup'),
              subtitle: Text(formData['forPickup'] ? 'Yes' : 'No'),
            ),
            ListTile(
              title: const Text('Organization ID'),
              subtitle: Text(formData['orgId'] ?? 'N/A'),
            ),
            ListTile(
              title: const Text('Organization Name'),
              subtitle: Text(formData['orgName'] ?? 'N/A'),
            ),
            ListTile(
              title: const Text('Pickup Addresses'),
              subtitle: Text(formData['pickupAddresses'] ?? 'N/A'),
            ),
            ListTile(
              title: const Text('Status'),
              subtitle: Text(getStatusString(formData['status'])),
            ),
            ListTile(
              title: const Text('Weight'),
              subtitle: Text('${formData['weight']} ${formData['weightUnit']}'),
            ),
          ],
        ),
      ),
    );
  }

  String getStatusString(int status) {
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

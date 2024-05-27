import 'package:flutter/material.dart';

class DisplayDonationDrives extends StatefulWidget {
  const DisplayDonationDrives({super.key});

  @override
  State<DisplayDonationDrives> createState() => _DisplayDonationDrivesState();
}

class _DisplayDonationDrivesState extends State<DisplayDonationDrives> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final orgEmail = arguments['selectedOrgEmail'];
    final orgId = arguments['orgID'];

    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: [
          Text(orgEmail),
          Text(orgId)
        ],
      ),
    );
  }
}
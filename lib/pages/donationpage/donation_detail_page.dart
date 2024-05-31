import 'package:flutter/material.dart';
import '../homepage/donation_model.dart';

import 'package:flutter/material.dart';

//Used to display the donation drives page.
class DonationDetailPage extends StatelessWidget {
  final Donation donation;

  DonationDetailPage({required this.donation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(donation.title),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF093731), // Dark green
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey[300],
                child: Image.network(
                  donation.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Text(
                donation.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                donation.description,
                style: TextStyle(fontSize: 16),
              ),
              if (donation.driveDetails != null)
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'Part of: ${donation.driveDetails}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              SizedBox(height: 10),
              Text(
                '\$${donation.amountRaised.toStringAsFixed(2)} raised of \$${donation.goal.toStringAsFixed(2)} goal',
                style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Donation Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Can check the information entered by donors',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Can update the status of each donation',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Status:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: DropdownButton<String>(
                  value: donation.status,
                  onChanged: (newValue) {
                    // Handle status change
                  },
                  items: <String>[
                    'Pending',
                    'Confirmed',
                    'Scheduled for Pick-up',
                    'Complete',
                    'Canceled',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  style: TextStyle(color: Colors.black), // Text color
                  dropdownColor: Color.fromRGBO(238, 242, 230, 1), // Background color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

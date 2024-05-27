import 'package:flutter/material.dart';
import '../homepage/donation_model.dart';

class DonationDetailsContainer extends StatelessWidget {
  final Widget coverPage;
  final Donation donation;

  DonationDetailsContainer({required this.coverPage, required this.donation});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(61, 131, 97, 1),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          coverPage,
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
          SizedBox(height: 10),
          if (donation.driveDetails != null)
            Text(
              'Part of: ${donation.driveDetails}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          SizedBox(height: 10),
          Text(
            '\$${donation.amountRaised.toStringAsFixed(2)} raised of \$${donation.goal.toStringAsFixed(2)} goal',
            style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

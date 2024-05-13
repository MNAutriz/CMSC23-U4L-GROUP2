import 'package:flutter/material.dart';
import 'donation_details.dart';

class DonationDetailsContainer extends StatelessWidget {
  final Widget coverPage;

  DonationDetailsContainer({required this.coverPage});

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
          DonationDetails(),
        ],
      ),
    );
  }
}

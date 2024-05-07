import 'package:flutter/material.dart';
import 'donation_model.dart';

class DonationCard extends StatelessWidget {
  final Donation donation;

  const DonationCard({required this.donation});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 4,
      color: Colors.white, // Set background color to plain white
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            donation.imageUrl,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  donation.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  donation.description,
                  style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${donation.amountRaised.toStringAsFixed(2)} raised of \$${donation.goal.toStringAsFixed(2)} goal',
                      style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 27, 118, 30), fontWeight: FontWeight.bold), 
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Donate button action
                      },
                      child: Text('See details'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

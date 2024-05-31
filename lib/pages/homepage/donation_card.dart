import 'package:cmsc23project/pages/donationpage/donation_page.dart';  // Importing the donation page
import 'package:flutter/material.dart';  // Importing the Flutter material library
import 'donation_model.dart';  // Importing the donation model
import '../donationpage/donation_detail_page.dart';  // Importing the donation detail page

class DonationCard extends StatelessWidget {  // Defining a stateless widget named DonationCard
  final Donation donation;  // Declaring a final variable to hold the donation object

  const DonationCard({required this.donation});  // Constructor to initialize the widget with a donation parameter

  @override
  Widget build(BuildContext context) {  // Override the build method to build the UI
    return Card(  // Card widget to display a card with elevation and rounded corners
      margin: EdgeInsets.all(10),  // Setting margin for the card
      elevation: 4,  // Setting elevation for the card
      color: Color(0xFFF2EEE6),  // Setting background color for the card
      child: Column(  // Column widget to arrange children vertically
        crossAxisAlignment: CrossAxisAlignment.stretch,  // Aligning children to the start of the cross axis
        children: [  // List of children widgets
          Image.network(  // Image widget to display image from the network
            donation.imageUrl,  // URL of the image
            height: 200,  // Setting the height of the image
            fit: BoxFit.cover,  // Setting the image fit property
          ),
          Padding(  // Padding widget to add padding around the content
            padding: EdgeInsets.all(8),  // Padding of 8 pixels on all sides
            child: Column(  // Column widget to arrange children vertically
              crossAxisAlignment: CrossAxisAlignment.start,  // Aligning children to the start of the cross axis
              children: [  // List of children widgets
                Text(  // Text widget to display donation title
                  donation.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  // Styling the text
                ),
                SizedBox(height: 5),  // SizedBox widget for vertical spacing
                Text(  // Text widget to display donation description
                  donation.description,
                  style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 0, 0, 0)),  // Styling the text
                ),
                if (donation.driveDetails != null)  // Conditionally rendering drive details if present
                  Padding(  // Padding widget to add padding
                    padding: EdgeInsets.only(top: 10),  // Padding on the top
                    child: Text(  // Text widget to display drive details
                      'Part of: ${donation.driveDetails}',
                      style: TextStyle(fontSize: 14, color: Colors.grey),  // Styling the text
                    ),
                  ),
                SizedBox(height: 10),  // SizedBox widget for vertical spacing
                Row(  // Row widget to arrange children horizontally
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Aligning children with space between
                  children: [  // List of children widgets
                    Text(  // Text widget to display donation amount raised and goal
                      '\$${donation.amountRaised.toStringAsFixed(2)} raised of \$${donation.goal.toStringAsFixed(2)} goal',
                      style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 27, 118, 30), fontWeight: FontWeight.bold),  // Styling the text
                    ),
                    ElevatedButton(  // ElevatedButton widget for navigating to donation detail page
                      onPressed: () {
                        Navigator.push(  // Navigating to the donation detail page on button press
                          context,
                          MaterialPageRoute(
                            builder: (context) => DonationDetailPage(donation: donation),  // Passing the donation object to the detail page
                          ),
                        );
                      },
                      child: Text('See details'),  // Text displayed on the button
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

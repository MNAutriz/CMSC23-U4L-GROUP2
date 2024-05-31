// Importing necessary packages and files
import 'package:cmsc23project/pages/donationpage/donation_page.dart';
import 'package:flutter/material.dart';
import 'donation_model.dart';
import '../donationpage/donation_detail_page.dart';

// Creating a stateless widget for the DonationCard
class DonationCard extends StatelessWidget {
  final Donation donation; // Donation object to display

  const DonationCard({required this.donation}); // Constructor to initialize donation object

  @override
  Widget build(BuildContext context) {
    // Returning a Card widget to display donation information
    return Card(
      margin: EdgeInsets.all(10), // Setting margin for the card
      elevation: 4, // Setting elevation for the card
      color: Color(0xFFF2EEE6), // Setting background color for the card
      child: Column( // Creating a column layout for the card
        crossAxisAlignment: CrossAxisAlignment.stretch, // Aligning children widgets along the start of the horizontal axis
        children: [ // List of children widgets for the column
          Image.network( // Displaying an image from a network URL
            donation.imageUrl, // Image URL obtained from the donation object
            height: 200, // Setting height for the image
            fit: BoxFit.cover, // Making sure the image covers the entire space allocated
          ),
          Padding( // Adding padding around the column content
            padding: EdgeInsets.all(8), // Setting padding for the content
            child: Column( // Creating another column layout for the content
              crossAxisAlignment: CrossAxisAlignment.start, // Aligning children widgets along the start of the horizontal axis
              children: [ // List of children widgets for the column
                Text( // Displaying the title of the donation
                  donation.title, // Title obtained from the donation object
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Setting text style for the title
                ),
                SizedBox(height: 5), // Adding a fixed height between widgets
                Text( // Displaying the description of the donation
                  donation.description, // Description obtained from the donation object
                  style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 0, 0, 0)), // Setting text style for the description
                ),
                if (donation.driveDetails != null) // Displaying drive details if available
                  Padding( // Adding padding around the drive details
                    padding: EdgeInsets.only(top: 10), // Setting padding for the drive details
                    child: Text( // Displaying the drive details
                      'Part of: ${donation.driveDetails}', // Drive details obtained from the donation object
                      style: TextStyle(fontSize: 14, color: Colors.grey), // Setting text style for the drive details
                    ),
                  ),
                SizedBox(height: 10), // Adding a fixed height between widgets
                Row( // Creating a row layout for displaying additional information and a button
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligning children widgets along the space between the main axis
                  children: [ // List of children widgets for the row
                    Text( // Displaying the amount raised and the goal
                      '\$${donation.amountRaised.toStringAsFixed(2)} raised of \$${donation.goal.toStringAsFixed(2)} goal', // Amount raised and goal obtained from the donation object
                      style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 27, 118, 30), fontWeight: FontWeight.bold), // Setting text style for the amount raised and goal
                    ),
                    ElevatedButton( // Creating an elevated button to navigate to the donation detail page
                      onPressed: () { // Defining the onPressed event handler
                        Navigator.push( // Navigating to the donation detail page on button press
                          context, // Providing the context for navigation
                          MaterialPageRoute( // Creating a material page route for navigation
                            builder: (context) => DonationDetailPage(donation: donation), // Building the donation detail page with the corresponding donation object
                          ),
                        );
                      },
                      child: Text('See details'), // Displaying text on the button
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

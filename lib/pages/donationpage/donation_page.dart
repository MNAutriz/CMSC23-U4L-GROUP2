import 'package:cmsc23project/pages/donationdrivepage/donation_drives_page.dart';
import 'package:cmsc23project/pages/homepage/home_page.dart';
import 'package:cmsc23project/pages/profilepage/profile_page.dart';
import 'package:cmsc23project/providers/donation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'donation_details_container.dart';
import '../homepage/donation_model.dart';

//Contains the entirety of the donations that is passed in the mobile application.
class DonationPage extends StatelessWidget {
  final List<Donation> donations;
  final String driveTitle;

  DonationPage({required this.donations, required this.driveTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(driveTitle),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF093731), // Dark green
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: donations.length,
        itemBuilder: (context, index) {
          final donation = donations[index];
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 4,
            color: Color(0xFFF2EEE6),
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
                      if (donation.driveDetails != null)
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Part of: ${donation.driveDetails}',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      SizedBox(height: 10),
                      Text(
                        '\$${donation.amountRaised.toStringAsFixed(2)} raised of \$${donation.goal.toStringAsFixed(2)} goal',
                        style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 27, 118, 30), fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Status:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
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
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF093731), // Dark green
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        currentIndex: Provider.of<DonationProvider>(context).selectedIndex,
        onTap: (index) {
          Provider.of<DonationProvider>(context, listen: false).setIndex(index);
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              break;
            case 1:
              // Already on DonationPage, no action needed
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DonationDrivesPage()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
              break;
            default:
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF093731), // Dark green
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF093731), // Dark green
            icon: Icon(Icons.monetization_on),
            label: 'Donation',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF093731), // Dark green
            icon: Icon(Icons.event),
            label: 'Donation Drives',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF093731), // Dark green
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
import 'package:cmsc23project/pages/donationdrivepage/add_donation_drive_page.dart';
import 'package:cmsc23project/pages/donationdrivepage/donation_drive_provider.dart';
import 'package:cmsc23project/pages/donationpage/donation_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cmsc23project/providers/donation_provider.dart';
import '../homepage/home_page.dart';
import '../profilepage/profile_page.dart';
import 'donation_drive_card.dart';
import 'edit_donation_drive_page.dart';

class DonationDrivesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final donationDrives = Provider.of<DonationDriveProvider>(context).donationDrives;

    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Drives Page'),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF093731), // Dark green
      ),
      backgroundColor: Color(0xFFF7F7F7), // Light background color
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: donationDrives.length,
        itemBuilder: (context, index) {
          final drive = donationDrives[index];
          return DonationDriveCard(donationDrive: drive);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDonationDrivePage()),  // Navigate to the new page
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF093731),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DonationPage(
                  donations: Provider.of<DonationProvider>(context).donations, 
                  driveTitle: 'All Donations'
                )),
              );
              break;
            case 2:
              // Already on the DonationDrivesPage
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/donation_provider.dart';
import '../donationpage/donation_page.dart';
import '../homepage/home_page.dart';
import '../profilepage/profile_page.dart';
import 'donation_drive_card.dart';

class DonationDrivesPage extends StatelessWidget {
  // List of image URLs for donation drives
  final List<String> imageUrls = [
    'https://adra.ph/wp-content/uploads/2017/09/Gift-Boxes-Aeta-4-1024x683.jpg',
    'https://spweb-uploads.s3.theark.cloud/2013/03/1827PH-G-022_Philippines.jpg',
    'https://southcotabato.gov.ph/wp-content/uploads/2022/07/295463385_425008249670423_1954468116908717607_n.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Drives Page'),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF093731), // Dark green
      ),
      backgroundColor: Color(0xFFF7F7F7), // Light background color
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: 3, // Replace with your donation drives count
        itemBuilder: (context, index) {
          return DonationDriveCard(
            title: 'Drive ${index + 1}',
            description: 'Description of donation drive ${index + 1}',
            imageUrl: imageUrls[index], // Select image URL based on index
            raisedAmount: 150.0,
            goalAmount: 500.0,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add CRUD operations for creating a new donation drive
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
                MaterialPageRoute(builder: (context) => DonationPage()),
              );
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

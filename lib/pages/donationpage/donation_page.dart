import 'package:cmsc23project/pages/donationdrivepage/donation_drives_page.dart';
import 'package:cmsc23project/pages/donationpage/donation_details.dart';
import 'package:cmsc23project/pages/homepage/home_page.dart';
import 'package:cmsc23project/pages/profilepage/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/donation_provider.dart';
import 'donation_details_container.dart';

class DonationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Page'),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF093731), // Dark green
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DonationDetailsContainer(
                coverPage: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300],
                  child: Image.network(
                    'https://spweb-uploads.s3.theark.cloud/2013/03/1827PH-G-022_Philippines.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              DonationDetailsContainer(
                coverPage: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300],
                  child: Image.network(
                    'https://adra.ph/wp-content/uploads/2017/09/Gift-Boxes-Aeta-4-1024x683.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              DonationDetailsContainer(
                coverPage: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300],
                  child: Image.network(
                    'https://spweb-uploads.s3.theark.cloud/2023/08/2355PH-H1-481_homescreen-765x460.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF093731), // Dark green
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              // Navigate to homepage (current page)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              break;
            case 1:
              // Navigate to donation page (current page)
              break;
            case 2:
              // Navigate to donation drives page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DonationDrivesPage()),
              );
              break;
            case 3:
              // Navigate to profile page
              Navigator.push(
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

void main() {
  runApp(MaterialApp(
    home: DonationPage(),
  ));
}

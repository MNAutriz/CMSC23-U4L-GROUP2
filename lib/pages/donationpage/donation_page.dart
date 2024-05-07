import 'package:cmsc23project/pages/donationdrivepage/donation_drives_page.dart';
import 'package:cmsc23project/pages/homepage/home_page.dart';
import 'package:cmsc23project/pages/profilepage/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/donation_provider.dart';

class DonationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Page'),
          backgroundColor: Color.fromARGB(255, 56, 179, 26), // Dark green
      ),
      body: Center(
        child: Text('This is the Donation Page'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF093731), // Dark green
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF093731), // Dark green
            icon: Icon(Icons.home),
            label: 'Homepage',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 56, 179, 26), // Dark green
            icon: Icon(Icons.monetization_on),
            label: 'Donation',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 13, 186, 105), // Dark green
            icon: Icon(Icons.event),
            label: 'Donation Drives',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(166, 90, 230, 3), // Dark green
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: Provider.of<DonationProvider>(context).selectedIndex,
        onTap: (index) {
          Provider.of<DonationProvider>(context, listen: false).setIndex(index);
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DonationPage()),
              );
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
      ),
    );
  }
}

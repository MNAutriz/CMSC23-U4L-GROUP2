import 'package:cmsc23project/providers/donation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'organization_provider.dart';
import '../homepage/home_page.dart';
import '../donationpage/donation_page.dart';
import '../donationdrivepage/donation_drives_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organization Profile'), foregroundColor: Colors.white,
            backgroundColor: Color(0xFF093731), // Dark green
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ChangeNotifierProvider<OrganizationProvider>(  
          create: (context) => OrganizationProvider(),
          child: Consumer<OrganizationProvider>(
            builder: (context, organizationProvider, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: AssetImage('images/coverpage.png'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    organizationProvider.organization.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'About the Organization',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    organizationProvider.organization.about,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Donation Status:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Switch(
                        value: organizationProvider.organization.donationsOpen,
                        onChanged: (value) {
                          organizationProvider.updateDonationsStatus(value);
                        },
                        activeTrackColor: Colors.green[700],
                        inactiveTrackColor: Colors.grey[400], // Set the inactive track color
                        inactiveThumbColor: Colors.grey[700], // Set the inactive thumb color
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF093731), // Dark green
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[300],
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

// Importing necessary packages and files
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cmsc23project/providers/donation_provider.dart';
import 'package:cmsc23project/providers/donation_drive_provider.dart';
import 'organization_provider.dart';
import '../homepage/home_page.dart';
import '../donationpage/donation_page.dart';
import '../donationdrivepage/donation_drives_page.dart';

// ProfilePage StatelessWidget
class ProfilePage extends StatelessWidget {
  // List of gallery image URLs
  final List<String> galleryImageUrls = [
    'https://usjr.edu.ph/wp-content/uploads/2019/12/F-350x350.jpg',
    'https://cdn.amebaowndme.com/madrid-prd/madrid-web/images/sites/1194991/1d141e9e26385a9af8b94ae468dc0645_19d705977f655bd13aeabba92126d894.jpg?width=512',
    'https://cdn.amebaowndme.com/madrid-prd/madrid-web/images/sites/1194991/3577c5c83d7d14cab6f4f0ec8dd0a2db_77c5238608b91e48924c13118911ca0d.jpg?width=512',
    'https://cpu.edu.ph/wp-content/uploads/2023/11/Ms.-Jaren-Marr-P.-Jaco-CESLC-Secretary-discussed-the-necessary-requirements-before-and-after-the-extension-works-to-the-outreach-coordinators.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    // Getting donations from DonationProvider
    final donations = Provider.of<DonationProvider>(context).donations;

    // Building the Scaffold for the ProfilePage
    return Scaffold(
      // App bar for the ProfilePage
      appBar: AppBar(
        title: Text('Organization Profile'), // App bar title
        foregroundColor: Colors.white, // Text color for app bar
        backgroundColor: Color(0xFF093731), // Background color for app bar (Dark green)
      ),
      body: ChangeNotifierProvider<OrganizationProvider>(
        create: (context) => OrganizationProvider(),
        child: Consumer<OrganizationProvider>(
          builder: (context, organizationProvider, _) {
            // SingleChildScrollView to allow scrolling
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20), // Spacer
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: NetworkImage(
                        'https://images-platform.99static.com//NnfsZfhWECwMKeuj4yxeInkbKN8=/0x126:874x1000/fit-in/500x500/99designs-contests-attachments/35/35657/attachment_35657633'), // Sample image URL
                  ),
                  SizedBox(height: 20), // Spacer
                  Text(
                    organizationProvider.organization.name, // Organization name
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10), // Spacer
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'About the Organization', // Section title
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10), // Spacer
                        Text(
                          organizationProvider.organization.about, // Organization description
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20), // Spacer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle, color: Colors.green[700]), // Check icon
                            SizedBox(width: 10), // Spacer
                            Text(
                              'Donation Status:', // Donation status text
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10), // Spacer
                            Switch(
                              value: organizationProvider.organization.donationsOpen, // Donation status switch
                              onChanged: (value) {
                                organizationProvider.updateDonationsStatus(value); // Update donation status
                              },
                              activeTrackColor: Colors.green[700], // Active switch track color
                              inactiveTrackColor: Colors.grey[400], // Inactive switch track color
                              inactiveThumbColor: Colors.grey[700], // Inactive switch thumb color
                            ),
                          ],
                        ),
                        SizedBox(height: 20), // Spacer
                        Text(
                          'Gallery', // Gallery section title
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10), // Spacer
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: galleryImageUrls.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(galleryImageUrls[index]), // Image URL
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20), // Spacer
                        Text(
                          'Mission', // Mission section title
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10), // Spacer
                        Text(
                          'Our mission is to make a difference by providing essential resources and support to those in need.', // Mission statement
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20), // Spacer
                        Text(
                          'Vision', // Vision section title
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10), // Spacer
                        Text(
                          'Our vision is a world where every individual has access to basic necessities and the opportunity to thrive.', // Vision statement
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20), // Spacer
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      // BottomNavigationBar for navigation options
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF093731), // Background color for BottomNavigationBar (Dark green)
        selectedItemColor: Colors.white, // Selected item color
        unselectedItemColor: Colors.grey[300], // Unselected item color
        currentIndex: Provider.of<DonationProvider>(context).selectedIndex, // Current index based on DonationProvider
        onTap: (index) {
          Provider.of<DonationProvider>(context, listen: false).setIndex(index); // Set index in DonationProvider
          // Navigate based on index
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
                  donations: donations, 
                  driveTitle: 'All Donations'
                )),
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
        // Bottom navigation items
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

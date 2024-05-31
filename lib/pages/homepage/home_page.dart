// Importing necessary packages and files
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/donation_provider.dart';
import 'donation_model.dart';
import 'donation_card.dart';
import '../donationpage/donation_page.dart';
import '../donationdrivepage/donation_drives_page.dart';
import '../profilepage/profile_page.dart';

// Creating a stateless widget for the HomePage
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Getting the list of donations from the donation provider
    final donations = Provider.of<DonationProvider>(context).donations;

    // Building the scaffold for the HomePage
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar widget for displaying the app bar
          SliverAppBar(
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(bottom: 8),
              title: const Text('Welcome to ElGives'), // Title for the app bar
              centerTitle: true,
              // Background decoration for the flexible space
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF093731), Color(0xFF1F5C44)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                // Centering content in the flexible space
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite, size: 50, color: Colors.white), // Icon
                      Text(
                        'ElGives', // App name
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Making a Difference Together', // Slogan
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // SliverToBoxAdapter for static content
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Image.asset('images/headerorga.png'), // Header image
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Our mission at ElGive is to empower communities through impactful donations. We aim to connect generous donors with causes that need their support, fostering a spirit of giving and making a significant difference in the lives of those in need. Join us in our journey to create a better world, one donation at a time.', // Mission statement
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                  GridView.count(
                    crossAxisCount: 4, // Increase the number of icons
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    children: [
                      _buildIcon(context, Icons.home, 'Home', 0), // Home icon
                      _buildIcon(context, Icons.monetization_on, 'Donate', 1), // Donation icon
                      _buildIcon(context, Icons.event, 'Drives', 2), // Drives icon
                      _buildIcon(context, Icons.person, 'Profile', 3), // Profile icon
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Top Donations', // Section title
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          // SliverList for displaying donation cards
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return DonationCard(donation: donations[index]);
              },
              childCount: donations.length,
            ),
          ),
        ],
      ),
      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF093731),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF093731),
            icon: Icon(Icons.home),
            label: 'Homepage',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF093731),
            icon: Icon(Icons.monetization_on),
            label: 'Donation',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF093731),
            icon: Icon(Icons.event),
            label: 'Donation Drives',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF093731),
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        // Setting the current index of the bottom navigation bar
        currentIndex: Provider.of<DonationProvider>(context).selectedIndex,
        // onTap event handler for bottom navigation bar items
        onTap: (index) {
          Provider.of<DonationProvider>(context, listen: false).setIndex(index);
          // Navigating to different pages based on the selected index
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
                MaterialPageRoute(builder: (context) => DonationPage(donations: donations, driveTitle: 'All Donations')),
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
      ),
    );
  }

  // Widget to build individual icons in the grid
  Widget _buildIcon(BuildContext context, IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        Provider.of<DonationProvider>(context, listen: false).setIndex(index);
        // Navigating to different pages based on the selected index
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
              MaterialPageRoute(builder: (context) => DonationPage(donations: Provider.of<DonationProvider>(context, listen: false).donations, driveTitle: 'All Donations')),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF093731),
            ),
            padding: EdgeInsets.all(16.0),
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(height: 5),
          Text(
            label, // Icon label
            style: TextStyle(color: Colors.black, fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}

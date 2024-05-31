import 'package:flutter/material.dart';  // Importing the Flutter material library
import 'package:provider/provider.dart';  // Importing the provider library for state management
import '../../providers/donation_provider.dart';  // Importing the donation provider
import 'donation_model.dart';  // Importing the donation model
import 'donation_card.dart';  // Importing the donation card widget
import '../donationpage/donation_page.dart';  // Importing the donation page
import '../donationdrivepage/donation_drives_page.dart';  // Importing the donation drives page
import '../profilepage/profile_page.dart';  // Importing the profile page

class HomePage extends StatelessWidget {  // Defining a stateless widget named HomePage
  @override
  Widget build(BuildContext context) {  // Override the build method to build the UI
    final donations = Provider.of<DonationProvider>(context).donations;  // Getting donations from the provider

    return Scaffold(  // Scaffold widget provides a basic structure for material design apps
      body: CustomScrollView(  // CustomScrollView widget for a scrollable list with slivers
        slivers: [  // List of slivers
          SliverAppBar(  // SliverAppBar widget for the app bar with scrolling effects
            expandedHeight: 250.0,  // Height of the expanded app bar
            flexibleSpace: FlexibleSpaceBar(  // FlexibleSpaceBar for the app bar content
              titlePadding: const EdgeInsets.only(bottom: 8),  // Padding for the title
              title: const Text('Welcome to ElGives'),  // Title of the app bar
              centerTitle: true,  // Aligning the title to the center
              background: Container(  // Container for the background of the app bar
                decoration: const BoxDecoration(  // Decoration for the container
                  gradient: LinearGradient(  // Creating a linear gradient
                    colors: [Color(0xFF093731), Color(0xFF1F5C44)],  // Gradient colors
                    begin: Alignment.topLeft,  // Gradient start position
                    end: Alignment.bottomRight,  // Gradient end position
                  ),
                ),
                child: const Center(  // Center widget to center its child
                  child: Column(  // Column widget to arrange children vertically
                    mainAxisAlignment: MainAxisAlignment.center,  // Aligning children to the center
                    children: [
                      Icon(Icons.favorite, size: 50, color: Colors.white),  // Heart icon
                      Text(  // Text widget for 'ElGives'
                        'ElGives',
                        style: TextStyle(  // Styling the text
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(  // Text widget for 'Making a Difference Together'
                        'Making a Difference Together',
                        style: TextStyle(  // Styling the text
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
          SliverToBoxAdapter(  // SliverToBoxAdapter for non-scrollable content
            child: Container(  // Container widget to contain non-scrollable content
              color: Colors.white,  // Setting background color for the container
              padding: const EdgeInsets.all(10.0),  // Padding for the container
              child: Column(  // Column widget to arrange children vertically
                children: [  // List of children widgets
                  Image.asset('images/headerorga.png'),  // Header image
                  const SizedBox(height: 5),  // SizedBox widget for vertical spacing
                  const Padding(  // Padding widget for padding around the text
                    padding: EdgeInsets.all(10.0),  // Padding for the text
                    child: Text(  // Text widget for mission statement
                      'Our mission at ElGive is to empower communities through impactful donations. We aim to connect generous donors with causes that need their support, fostering a spirit of giving and making a significant difference in the lives of those in need. Join us in our journey to create a better world, one donation at a time.',
                      textAlign: TextAlign.center,  // Aligning the text to the center
                      style: TextStyle(fontSize: 16, color: Colors.black87),  // Styling the text
                    ),
                  ),
                  GridView.count(  // GridView widget for displaying icons
                    crossAxisCount: 4,  // Number of columns in the grid
                    shrinkWrap: true,  // Shrinking the grid to its content
                    physics: const NeverScrollableScrollPhysics(),  // Disabling scrolling
                    mainAxisSpacing: 10.0,  // Spacing between columns
                    crossAxisSpacing: 10.0,  // Spacing between rows
                    children: [  // List of children widgets
                      _buildIcon(context, Icons.home, 'Home', 0),  // Icon for homepage
                      _buildIcon(context, Icons.monetization_on, 'Donate', 1),  // Icon for donation page
                      _buildIcon(context, Icons.event, 'Drives', 2),  // Icon for donation drives page
                      _buildIcon(context, Icons.person, 'Profile', 3),  // Icon for profile page
                    ],
                  ),
                  const SizedBox(height: 20),  // SizedBox widget for vertical spacing
                  const Text(  // Text widget for 'Top Donations'
                    'Top Donations',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),  // Styling the text
                  ),
                  const SizedBox(height: 10),  // SizedBox widget for vertical spacing
                ],
              ),
            ),
          ),
          SliverList(  // SliverList for a list of items
            delegate: SliverChildBuilderDelegate(  // Delegate for building children lazily
              (context, index) {  // Builder function for building children
                return DonationCard(donation: donations[index]);  // Building DonationCard widget for each donation
              },
              childCount: donations.length,  // Total number of children
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(  // BottomNavigationBar widget for bottom navigation
        backgroundColor: const Color(0xFF093731),  // Background color of the bottom navigation bar
        selectedItemColor: Colors.white,  // Color of the selected item
        unselectedItemColor: Colors.white.withOpacity(0.6),  // Color of the unselected item
        items: const <BottomNavigationBarItem>[  // List of bottom navigation items
          BottomNavigationBarItem(  // Bottom navigation item for homepage
            backgroundColor: Color(0xFF093731),  // Background color of the item
            icon: Icon(Icons.home),  // Icon for homepage
            label: 'Homepage',  // Label for homepage
          ),
          BottomNavigationBarItem(  // Bottom navigation item for donation page
            backgroundColor: Color(0xFF093731),  // Background color of the item
            icon: Icon(Icons.monetization_on),  // Icon for donation page
            label: 'Donation',  // Label for donation page
          ),
          BottomNavigationBarItem(  // Bottom navigation item for donation drives page
            backgroundColor: Color(0xFF093731),  // Background color of the item
            icon: Icon(Icons.event),  // Icon for donation drives page
            label: 'Donation Drives',  // Label for donation drives page
          ),
          BottomNavigationBarItem(  // Bottom navigation item for profile page
            backgroundColor: Color(0xFF093731),  // Background color of the item
            icon: Icon(Icons.person),  // Icon for profile page
            label: 'Profile',  // Label for profile page
          ),
        ],
        currentIndex: Provider.of<DonationProvider>(context).selectedIndex,  // Current index of the bottom navigation
        onTap: (index) {  // Callback function for handling navigation item taps
          Provider.of<DonationProvider>(context, listen: false).setIndex(index);  // Setting the selected index in the provider
          switch (index) {  // Switch statement for handling different navigation items
            case 0:  // Homepage
              Navigator.pushReplacement(  // Navigating to the homepage
                context,
                MaterialPageRoute(builder: (context) => HomePage()),  // Building HomePage widget
              );
              break;
            case 1:  // Donation page
              Navigator.pushReplacement(  // Navigating to the donation page
                context,
                MaterialPageRoute(builder: (context) => DonationPage(donations: donations, driveTitle: 'All Donations')),  // Building DonationPage widget
              );
              break;
            case 2:  // Donation drives page
              Navigator.pushReplacement(  // Navigating to the donation drives page
                context,
                MaterialPageRoute(builder: (context) => DonationDrivesPage()),  // Building DonationDrivesPage widget
              );
              break;
            case 3:  // Profile page
              Navigator.pushReplacement(  // Navigating to the profile page
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),  // Building ProfilePage widget
              );
              break;
            default:
              break;
          }
        },
      ),
    );
  }

  Widget _buildIcon(BuildContext context, IconData icon, String label, int index) {  // Widget to build navigation icons
    return GestureDetector(  // GestureDetector widget for handling taps
      onTap: () {  // Callback function for tap event
        Provider.of<DonationProvider>(context, listen: false).setIndex(index);  // Setting the selected index in the provider
        switch (index) {  // Switch statement for handling different navigation items
          case 0:  // Homepage
            Navigator.pushReplacement(  // Navigating to the homepage
              context,
              MaterialPageRoute(builder: (context) => HomePage()),  // Building HomePage widget
            );
            break;
          case 1:  // Donation page
            Navigator.pushReplacement(  // Navigating to the donation page
              context,
              MaterialPageRoute(builder: (context) => DonationPage(donations: Provider.of<DonationProvider>(context, listen: false).donations, driveTitle: 'All Donations')),  // Building DonationPage widget
            );
            break;
          case 2:  // Donation drives page
            Navigator.pushReplacement(  // Navigating to the donation drives page
              context,
              MaterialPageRoute(builder: (context) => DonationDrivesPage()),  // Building DonationDrivesPage widget
            );
            break;
          case 3:  // Profile page
            Navigator.pushReplacement(  // Navigating to the profile page
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),  // Building ProfilePage widget
            );
            break;
          default:
            break;
        }
      },
      child: Column(  // Column widget to arrange children vertically
        mainAxisSize: MainAxisSize.min,  // Setting main axis size to minimum
        mainAxisAlignment: MainAxisAlignment.center,  // Aligning children to the center
        children: [  // List of children widgets
          Container(  // Container widget to contain the icon
            decoration: BoxDecoration(  // Decoration for the container
              shape: BoxShape.circle,  // Setting shape to circle
              color: Color(0xFF093731),  // Setting background color for the container
            ),
            padding: EdgeInsets.all(16.0),  // Padding for the container
            child: Icon(icon, color: Colors.white),  // Icon widget for the icon
          ),
          SizedBox(height: 5),  // SizedBox widget for vertical spacing
          Text(  // Text widget for label
            label,
            style: TextStyle(color: Colors.black, fontSize: 12.0),  // Styling the text
          ),
        ],
      ),
    );
  }
}

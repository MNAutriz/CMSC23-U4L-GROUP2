import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/donation_provider.dart';
import 'donation_model.dart';
import 'donation_card.dart';
import '../donationpage/donation_page.dart';
import '../donationdrivepage/donation_drives_page.dart';
import '../profilepage/profile_page.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final donations = Provider.of<DonationProvider>(context).donations;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Welcome to ElGive'),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF093731), Color(0xFF1F5C44)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite, size: 50, color: Colors.white),
                      Text(
                        'ElGive',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Making a Difference Together',
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
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Image.asset('images/headerorga.png'),
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Our mission at ElGive is to empower communities through impactful donations. We aim to connect generous donors with causes that need their support, fostering a spirit of giving and making a significant difference in the lives of those in need. Join us in our journey to create a better world, one donation at a time.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                  GridView.count(
                    crossAxisCount: 4, // Increase the number of icons
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    children: [
                      _buildIcon(context, Icons.home, 'Home', 0),
                      _buildIcon(context, Icons.monetization_on, 'Donate', 1),
                      _buildIcon(context, Icons.event, 'Drives', 2),
                      _buildIcon(context, Icons.person, 'Profile', 3),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Top Donations',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
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

  Widget _buildIcon(BuildContext context, IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
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
            label,
            style: TextStyle(color: Colors.black, fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}

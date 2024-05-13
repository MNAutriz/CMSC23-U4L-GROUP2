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
        backgroundColor: Color(0xFF093731), // Dark green
      ),
      backgroundColor: Color.fromRGBO(214, 205, 164, 1), // Dark green
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
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSD7XynQ15godQjXpaP30wvHkd0qOkvySs8LKctDg905nGCPYepu3LMCVQm-kJytKa6Rg8&usqp=CAU',
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
                    'https://www.fao.org/uploads/pics/web24954_030.jpg',
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
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrgQJglUyVFM2cGVhXM1Mogiqh_RVyO0hF3oxg1fV6c0XEvM8JGsaBR-Tv770DeSU7NXU&usqp=CAU',
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

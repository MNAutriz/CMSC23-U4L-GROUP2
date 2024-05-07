import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/donation_provider.dart';
import 'donation_model.dart';
import 'donation_card.dart';
import '../donationpage/donation_page.dart';
import '../donationdrivepage/donation_drives_page.dart';
import '../profilepage/profile_page.dart';

class HomePage extends StatelessWidget {
  final List<Donation> donations = [
    Donation(
      title: 'Help Build a School in Africa',
      description: 'Support our efforts to build a school in rural Africa and provide education to children in need.',
      imageUrl: 'https://www.fao.org/uploads/pics/web24954_030.jpg',
      amountRaised: 2500,
      goal: 10000,
    ),
    Donation(
      title: 'Save the Rainforest',
      description: 'Contribute to our campaign to protect endangered species and preserve the rainforest ecosystem.',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrgQJglUyVFM2cGVhXM1Mogiqh_RVyO0hF3oxg1fV6c0XEvM8JGsaBR-Tv770DeSU7NXU&usqp=CAU',
      amountRaised: 15000,
      goal: 50000,
    ),
    Donation(
      title: 'Provide Meals for the Homeless',
      description: 'Join us in feeding the homeless and providing support to those in need in our community.',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSD7XynQ15godQjXpaP30wvHkd0qOkvySs8LKctDg905nGCPYepu3LMCVQm-kJytKa6Rg8&usqp=CAU',
      amountRaised: 7500,
      goal: 10000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation App'),
        backgroundColor: Color(0xFF093731), // Dark green
      ),
      body: ListView.builder(
        itemCount: donations.length,
        itemBuilder: (context, index) {
          return DonationCard(donation: donations[index]);
        },
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
              // Navigate to homepage (current page)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              break;
            case 1:
              // Navigate to donation page
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

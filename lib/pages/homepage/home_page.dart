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
      description: "Support our initiative to construct a school in rural Africa, offering children access to education and a pathway out of poverty. By contributing, you're providing them with a safe and nurturing environment to learn, grow, and thrive. Let's come together to build a brighter future for these deserving children. Join us in making a difference through education.",
      imageUrl: 'https://edgedavao.net/wp-content/uploads/2017/03/Poor-residents-photo.jpg',
      amountRaised: 2500,
      goal: 10000,
    ),
    Donation(
      title: 'Save the Rainforest',
      description: 'Join our campaign to safeguard endangered species and preserve the vital rainforest ecosystem. The rainforests are home to an incredible diversity of life, hosting millions of plant and animal species, many of which are found nowhere else on Earth. However, rampant deforestation, habitat destruction, and poaching pose significant threats to this precious ecosystem and the species that call it home.',
      imageUrl: 'https://philippines.licas.news/wp-content/uploads/2020/08/20200701-Licas-Aeta-Hungey-2-scaled-e1597557910736.jpg',
      amountRaised: 15000,
      goal: 50000,
    ),
    Donation(
      title: 'Provide Meals for the Homeless',
      description: 'We invite you to join us in a meaningful endeavor to support the homeless and vulnerable members of our community by contributing to our initiative to provide food and essential support services. Every day, countless individuals struggle to meet their basic needs, facing hunger, homelessness, and despair. Together, we can make a difference in their lives and offer a glimmer of hope in their darkest moments.',
      imageUrl: 'https://adra.ph/wp-content/uploads/2017/09/Gift-Boxes-Aeta-7-1024x683.jpg',
      amountRaised: 7500,
      goal: 10000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Welcome to ElGive'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF093731), Color(0xFF1F5C44)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
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
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Image.asset(
                    'images/headerorga.png',
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
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
                  SizedBox(height: 20),
                  Text(
                    'Top Donations',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
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
        backgroundColor: Color(0xFF093731),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        items: <BottomNavigationBarItem>[
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DonationDrivesPage()),
              );
              break;
            case 3:
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

  Widget _buildIcon(BuildContext context, IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DonationDrivesPage()),
            );
            break;
          case 3:
            Navigator.push(
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

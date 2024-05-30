import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/donation_provider.dart';
import '../homepage/home_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    final donationProvider = Provider.of<DonationProvider>(context);

    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        title: Text("Organization's View"),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF093731), // Dark green
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Make a Difference Today!',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF093731), // Green
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Your donations can change lives. Choose a cause and contribute today.',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black, // Gray
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40.0),
            Image.asset(
              'images/coverpage.png',
              height: 400.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to home page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF093731), // Dark green
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text(
                'Donate Now',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //logout
  Drawer get drawer => Drawer(
          child: Container(
        color: const Color(0xFFEEF2E6),
        child: ListView(padding: EdgeInsets.zero, children: [
          const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF1C6758)),
              child: Text("Settings",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color(0xFFEEF2E6)))),
          ListTile(
            title: const Center(
              child: Text(
                "Log out",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF1C6758)),
              ),
            ),
            onTap: () {
              context.read<UserAuthProvider>().signOut();
            },
          ),
        ]),
      ));
}

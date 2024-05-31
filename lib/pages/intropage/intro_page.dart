// Importing necessary packages and files
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/donation_provider.dart';
import '../homepage/home_page.dart';

// Creating a stateful widget for the IntroPage
class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

// State class for the IntroPage
class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    // Getting the donation provider instance
    final donationProvider = Provider.of<DonationProvider>(context);

    // Building the scaffold for the IntroPage
    return Scaffold(
      // Drawer for navigation options
      drawer: drawer,
      // App bar for the IntroPage
      appBar: AppBar(
        title: const Text("Organization's View"), // Title for the app bar
        foregroundColor: Colors.white, // Text color for the app bar
        backgroundColor: Color(0xFF093731), // Background color for the app bar (Dark green)
      ),
      // Body of the IntroPage
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Make a Difference Today!', // Title text
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF093731), // Green
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0), // Spacer
            const Text(
              'Your donations can change lives. Choose a cause and contribute today.', // Description text
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black, // Gray
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40.0), // Spacer
            Image.asset(
              'images/coverpage.png', // Image asset
              height: 400.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 40.0), // Spacer
            ElevatedButton(
              onPressed: () {
                // Navigate to home page on button press
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF093731), // Dark green
                padding: EdgeInsets.symmetric(vertical: 16.0), // Button padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // Button border radius
                ),
              ),
              child: const Text(
                'Donate Now', // Button text
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

  // Drawer widget for displaying logout option
  Drawer get drawer => Drawer(
          child: Container(
        color: const Color(0xFFEEF2E6), // Drawer background color
        child: ListView(padding: EdgeInsets.zero, children: [
          const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF1C6758)), // Header background color
              child: Text("Settings", // Header text
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color(0xFFEEF2E6)))),

          // ListTile for logout option
          ListTile(
            title: const Center(
              child: Text(
                "Log out", // Logout option text
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF1C6758)), // Text style
              ),
            ),
            onTap: () {
              // Signing out user on tap
              context.read<UserAuthProvider>().signOut();
              // Navigating to the login page
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ]),
      ));
}

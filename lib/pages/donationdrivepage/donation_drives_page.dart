import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/pages/donationdrivepage/add_donation_drive_page.dart';
import 'package:cmsc23project/pages/donationdrivepage/donation_drive_card.dart';
import 'package:cmsc23project/pages/donationdrivepage/donation_drive_model.dart';
import 'package:cmsc23project/pages/donationpage/donation_page.dart';
import 'package:cmsc23project/pages/homepage/home_page.dart';
import 'package:cmsc23project/pages/profilepage/profile_page.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:cmsc23project/providers/donation_drive_provider.dart';
import 'package:cmsc23project/providers/donation_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationDrivesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _drivesStream =
        Provider.of<DonationDriveProvider>(context).drivesStream;
    final selectedIndex = Provider.of<DonationProvider>(context).selectedIndex;
    User? user = context.watch<UserAuthProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Drives Page',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF093731), // Dark green color for the app bar
      ),
      body: StreamBuilder(
        stream: _drivesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error encountered! ${snapshot.error}"));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text("No donation drives in collection."));
          }

          // filter according to org email
          final docs = snapshot.data!.docs.where((doc) => doc['orgEmail'] == user!.email).toList();

          if(docs.isEmpty) return Center(child: Text("No donation drives associated with organization"));

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final driveData = docs[index].data() as Map<String, dynamic>;
              final drive = DonationDrive.fromJson(driveData);
              drive.id = docs[index].id; // set the document id

              return DonationDriveCard(donationDrive: drive, orgEmail: user!.email.toString());
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDonationDrivePage(orgEmail: user!.email.toString())),
          );
          
          // // change to pushnamed so that i can pass arguments 
          // Navigator.pushNamed(context, '/organization/donationdrives/add', arguments: {
          //   'orgEmail': user!.email
          // });
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF093731), // Dark green color for the button
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            Color(0xFF093731), // Dark green color for the bottom navigation bar
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) {
          Provider.of<DonationProvider>(context, listen: false).setIndex(index);
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
              break;
            case 1:
              final donations =
                  Provider.of<DonationProvider>(context, listen: false)
                      .donations;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DonationPage(
                    donations: donations,
                    driveTitle: 'All Donations',
                  ),
                ),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DonationDrivesPage()));
              break;
            case 3:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
              break;
            default:
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF093731), // Dark green
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF093731),
            icon: Icon(Icons.monetization_on),
            label: 'Donations',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF093731),
            icon: Icon(Icons.event),
            label: 'Drives',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF093731),
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

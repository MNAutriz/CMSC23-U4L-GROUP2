import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/pages/donationdrivepage/add_donation_drive_page.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:cmsc23project/providers/donation_drive_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationDrivesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Stream<QuerySnapshot> _drivesStream = context.watch<DonationDriveProvider>().drivesStream;
    User? user = context.watch<UserAuthProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Drives Page', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF093731),
      ),
      body: StreamBuilder(
        stream: _drivesStream,
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Center(child: Text("Error encountered! ${snapshot.error}"));
          } else if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty){
            return const Center(child: Text("No donation drives in collection."));
          }

          //filer drives where orgEmail is the same as logged in email
          var docs = snapshot.data!.docs.where((doc) => doc['orgEmail'] == user!.email).toList();
          // var docs = snapshot.data!.docs;

          if(docs.isEmpty) {
            return const Center(child: Text("No donation drives for your organization"));
          }
          
          // render donation drives
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var drive = docs[index].data() as Map<String, dynamic>;
              var driveId = docs[index].id;

              return Card(
                child: Column(
                  children: [
                    Text("Drive id: $driveId"),
                    Text("Drive title: ${drive['title']}"),
                    Text("Drive description: ${drive['description']}"),
                    // Text("Drive imageURLs: ${drive['imageUrls']}"),
                    Text("Drive donations: ${drive['donations']}"),
                    Text('Organization Email: ${drive['orgEmail']}')
                  ]
                )
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDonationDrivePage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF093731),
      ),
    );
  }
}

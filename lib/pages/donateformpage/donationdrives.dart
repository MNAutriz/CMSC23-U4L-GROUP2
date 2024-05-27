import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/providers/donation_drive_provider.dart';
import 'package:cmsc23project/providers/organization_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayDonationDrives extends StatefulWidget {
  const DisplayDonationDrives({super.key});

  @override
  State<DisplayDonationDrives> createState() => _DisplayDonationDrivesState();
}

class _DisplayDonationDrivesState extends State<DisplayDonationDrives> {
  @override
  Widget build(BuildContext context) {

    // extract arguments
    final Map<String, dynamic> arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final orgEmail = arguments['selectedOrgEmail'];
    final orgId = arguments['orgID'];

    // get stream of needed stuff 5am na pls gusto ko na matulog
    // Stream<QuerySnapshot> _orgsStream = context.watch<OrganizationProvider>().organization;
    Stream<QuerySnapshot> _drivesStream = context.watch<DonationDriveProvider>().drivesStream;

    return Scaffold(
      appBar: AppBar(

      ),
      body: StreamBuilder(
        stream: _drivesStream,
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Center(
              child: Text("Error encountered! ${snapshot.error}")
            );
          } else if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator()
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No drives on collection"));
          }

          // filter donation drives where org email is the same as the orgemail in the argument
          var docs = snapshot.data!.docs.where((doc) => doc['orgEmail'] == orgEmail).toList(); // convert to list so that i can access it like a list haha

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var drive = docs[index].data() as Map<String, dynamic>;
              var driveId = docs[index].id;


              // values:
              // title
              // description
              // imageUrls
              //donations list
              // org email
              return Card(
                child: Column(
                  children: [
                    Text(drive['title'],)
                  ],
                )
              );
            },
          );
        }
      )
    );
  }
}
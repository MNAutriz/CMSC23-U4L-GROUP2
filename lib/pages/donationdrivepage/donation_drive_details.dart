import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/providers/donor_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'donation_drive_model.dart';

class DonationDriveDetailsPage extends StatelessWidget {
  final DonationDrive donationDrive;
  final String orgEmail;

  DonationDriveDetailsPage({required this.donationDrive, required this.orgEmail});

  @override
  Widget build(BuildContext context) {

    Stream<QuerySnapshot> _formsStream = context.watch<DonorFormProvider>().formsStream;

      return Scaffold(
        appBar: AppBar(
          title: const Text("Donation Drive Info")
        ),
        body: Column(
          children: [
            Column(
              children: [
                Text(donationDrive.title),
                Text(donationDrive.description),
                // Text(donationDrive.donations.toString()),
                const Text("FORMS:")
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: _formsStream,
                builder: (context, snapshot) {

                    if (snapshot.hasError) {
                    return Center(child: Text("Error encountered! ${snapshot.error}"));
                  } else if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No donation drives in collection."));
                  }
              
                  // filter forms that have same orgemail
                  final docs = snapshot.data!.docs.where((doc) => doc['donationDriveId'] == donationDrive.id).toList();
              
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index){
                      final formData = docs[index].data() as Map<String, dynamic>;
                      return Card(
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () {
                            // display form info
                            // TODO: create form info page (can update status inside this page)
                          },
                          child: Column(
                            children: [
                              Text(docs[index].id),
                              Text(formData['donationTypes'].toString()),
                            ]
                          ),
                        )
                      );
                    },
                  );
                }
              ),
            ),
          ],
        )
      );


    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(donationDrive.title),
    //     backgroundColor: Color(0xFF093731), // Dark green color for the app bar
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: SingleChildScrollView(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             donationDrive.title,
    //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //           ),
    //           SizedBox(height: 10),
    //           Text(
    //             donationDrive.description,
    //             style: TextStyle(fontSize: 16),
    //           ),
    //           SizedBox(height: 20),
    //           Text(
    //             'Donations:',
    //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //           ),
    //           ListView.builder(
    //             shrinkWrap: true,
    //             physics: NeverScrollableScrollPhysics(),
    //             itemCount: donationDrive.donations.length,
    //             itemBuilder: (context, index) {
    //               final donation = donationDrive.donations[index];
    //               return ListTile(
    //                 title: Text(donation.title),
    //                 subtitle: Text(donation.description),
    //                 trailing: Text('\$${donation.amountRaised} / \$${donation.goal}'),
    //               );
    //             },
    //           ),
    //           SizedBox(height: 20),
    //           const Text(
    //             'Proof of Donations:',
    //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //           ),
    //           ListView.builder(
    //             shrinkWrap: true,
    //             physics: const NeverScrollableScrollPhysics(),
    //             itemCount: donationDrive.donationProofs.length,
    //             itemBuilder: (context, index) {
    //               final proofUrl = donationDrive.donationProofs[index];
    //               return Padding(
    //                 padding: const EdgeInsets.symmetric(vertical: 8.0),
    //                 child: Image.network(proofUrl),
    //               );
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

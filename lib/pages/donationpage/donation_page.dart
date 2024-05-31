import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cmsc23project/providers/donor_form_provider.dart';
import 'package:cmsc23project/pages/donationdrivepage/form_details_page/form_details.dart';

class DonationPage extends StatelessWidget {
  const DonationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF093731),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Provider.of<DonorFormProvider>(context).formsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No donations available.",
                style: TextStyle(color: Colors.black),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final formData =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FormDetailsPage(formData: formData),
                          ),
                        );
                      },
                      child: ListTile(
                        // title: Text(
                        //   "Donation by: ${formData['donorEmail']}",
                        //   style: const TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 16,
                        //     color: Color(0xFF1C6758),
                        //   ),
                        //   textAlign: TextAlign.center,
                        // ),
                        title: FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('donation_drives')
                              .doc(formData['donationDriveId'])
                              .get(),
                          builder: (context, driveSnapshot) {
                            if (driveSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text(
                                "Fetching donation drive name...",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              );
                            }
                            if (driveSnapshot.hasError) {
                              return Text(
                                "Error: ${driveSnapshot.error}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                ),
                              );
                            }
                            final driveData = driveSnapshot.data!;
                            return Text(
                              driveData['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFF1C6758),
                              ),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Text(
                              "Donation Type: ${formData['donationTypes']}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('donation_drives')
                                  .doc(formData['donationDriveId'])
                                  .get(),
                              builder: (context, driveSnapshot) {
                                if (driveSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Text(
                                    "Fetching donation drive name...",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  );
                                }
                                if (driveSnapshot.hasError) {
                                  return Text(
                                    "Error: ${driveSnapshot.error}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                    ),
                                  );
                                }
                                final driveData = driveSnapshot.data!;
                                return Text(
                                  "Donation Drive: ${driveData['title']}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                );
                              },
                            ),
                            Text(
                          "Donation by: ${formData['donorEmail']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.start,
                        ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

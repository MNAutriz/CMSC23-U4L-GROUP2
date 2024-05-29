import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:cmsc23project/providers/donation_drive_provider.dart';

class DisplayDonationDrives extends StatefulWidget {
  const DisplayDonationDrives({Key? key}) : super(key: key);

  @override
  State<DisplayDonationDrives> createState() => _DisplayDonationDrivesState();
}

class _DisplayDonationDrivesState extends State<DisplayDonationDrives> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final orgEmail = arguments['selectedOrgEmail'];

    Stream<QuerySnapshot> drivesStream =
        context.watch<DonationDriveProvider>().drivesStream;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFFEEF2E6)),
        title: const Text('Donation Drives',
            style: TextStyle(
                color: Color(0xFFEEF2E6), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF093731),
      ),
      backgroundColor: const Color(0xFFEEF2E6),
      body: StreamBuilder(
        stream: drivesStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error encountered! ${snapshot.error}"));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No drives found"));
          }

          var docs = snapshot.data!.docs
              .where((doc) => doc['orgEmail'] == orgEmail)
              .toList();

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var drive = docs[index].data() as Map<String, dynamic>;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: const Color(0xFFEEF2E6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.network(
                          drive['coverPhoto'] ??
                              'https://via.placeholder.com/150',
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              drive['title'] ?? '',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF093731),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              drive['description'] ?? 'No description',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF3D8361),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

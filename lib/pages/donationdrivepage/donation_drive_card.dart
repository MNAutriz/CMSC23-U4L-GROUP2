import '../../providers/donation_drive_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../donationdrivepage/donation_drive_model.dart';
import 'edit_donation_drive_page.dart';
import 'donation_drive_details.dart';

/// A stateless widget that displays a card with information about a donation drive.
/// It provides options to see details, edit, or delete the donation drive.
class DonationDriveCard extends StatelessWidget {
  final DonationDrive donationDrive;
  final String orgEmail;

  /// Constructor for DonationDriveCard which takes a donation drive and organization email as parameters.
  DonationDriveCard({required this.donationDrive, required this.orgEmail});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(10),
      elevation: 4,
      color: Colors.white, // Set the background color to white
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// Display the cover photo of the donation drive or a placeholder image if not available.
          Image.network(
            donationDrive.coverPhoto.isNotEmpty
                ? donationDrive.coverPhoto
                : 'https://via.placeholder.com/150',
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Display the title of the donation drive.
                Text(
                  donationDrive.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                /// Display the description of the donation drive.
                Text(
                  donationDrive.description,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Button to navigate to the details page of the donation drive.
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DonationDriveDetailsPage(
                                donationDrive: donationDrive,
                                orgEmail: orgEmail,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xFFEEF2E6),
                          backgroundColor: const Color(0xFF093731), // text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16), // rounded corners
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16), // padding
                        ),
                        child: const Text(
                          "See Details",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditDonationDrivePage(
                                    donationDrive: donationDrive),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFFEEF2E6),
                            backgroundColor: const Color(0xFF093731), // text color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16), // rounded corners
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16), // padding
                          ),
                          child: const Text(
                            "Edit",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ElevatedButton(
                          onPressed: () {
                                                        showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: const Color(0xFF093731),
                                  title: const Text(
                                    "Confirmation",
                                    style: TextStyle(color: Color(0xFFEEF2E6)),
                                  ),
                                  content: const Text(
                                    "Are you sure you want to delete this donation drive?",
                                    style: TextStyle(color: Color(0xFFEEF2E6)),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "No",
                                        style: TextStyle(color: Color(0xFFEEF2E6)),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Provider.of<DonationDriveProvider>(context,
                                        listen: false)
                                        .deleteDonationDrive(donationDrive.id);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "Yes",
                                        style: TextStyle(color: Color(0xFFEEF2E6)),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFFEEF2E6),
                            backgroundColor: Colors.red, // text color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16), // rounded corners
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16), // padding
                          ),
                          child: const Text(
                            "Delete",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

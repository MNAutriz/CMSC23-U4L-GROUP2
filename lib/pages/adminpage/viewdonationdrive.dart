import 'package:flutter/material.dart';

class ViewDonationDrive extends StatefulWidget {
  //donation drive instance
  final Map<String, dynamic> donationDrive;
  const ViewDonationDrive({super.key, required this.donationDrive});

  @override
  State<ViewDonationDrive> createState() => _ViewDonationDriveState();
}

class _ViewDonationDriveState extends State<ViewDonationDrive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFEEF2E6),
        appBar: AppBar(
          title: Text(
            "Donation Drive Details",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF1C6758),
          foregroundColor: const Color(0xFFEEF2E6),
        ),

        //details of friend
        body: details());
  }

  //details widget
  Widget details() {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //donation drive title
              Center(
                child: Text("${widget.donationDrive['title']}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 5),
              //photo of donation drive
              Center(
                child: Image.network(widget.donationDrive['coverPhoto']),
              ),
              const SizedBox(height: 5),
              Column(
                children: [
                  //description of donation drive
                  Text(
                    "Description:",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text("${widget.donationDrive['description']}",
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    "Number of donations: ",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text("${widget.donationDrive['donations'].length}",
                      style: const TextStyle(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

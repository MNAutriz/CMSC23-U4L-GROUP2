import 'package:flutter/material.dart';

class DonationDrivesPageCopy extends StatelessWidget {
  // List of image URLs for donation drives
  final List<String> imageUrls = [
    'https://adra.ph/wp-content/uploads/2017/09/Gift-Boxes-Aeta-4-1024x683.jpg',
    'https://spweb-uploads.s3.theark.cloud/2013/03/1827PH-G-022_Philippines.jpg',
    'https://southcotabato.gov.ph/wp-content/uploads/2022/07/295463385_425008249670423_1954468116908717607_n.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E6),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFFEEF2E6)),
        title: const Text("Choose a donation drive!", style: TextStyle(color: Color(0xFFEEF2E6), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF093731),
      ),
      body: ListView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/donor/donate');
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,  // Aligns all children to the left
                  children: [
                    Image.network(imageUrls[index]),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Drive $index",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Drive details"),
                    ),
                    SizedBox(height: 8.0),  // Adding some space at the bottom
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
                      child: Text("\$1500 raised out of 5000 goal.", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

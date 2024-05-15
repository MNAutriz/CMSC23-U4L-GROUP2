import 'package:flutter/material.dart';

class DisplayDonors extends StatefulWidget {
  const DisplayDonors({super.key});

  @override
  State<DisplayDonors> createState() => _DisplayDonorsState();
}

class _DisplayDonorsState extends State<DisplayDonors> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(0xFFEEF2E6),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "View Donors Here",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Color(0xFF1C6758)),
                  ),
                ),
              ]),
        ));
  }
}

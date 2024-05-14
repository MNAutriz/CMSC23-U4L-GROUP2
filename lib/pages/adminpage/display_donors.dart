import 'package:flutter/material.dart';

class DisplayDonors extends StatefulWidget {
  const DisplayDonors({super.key});

  @override
  State<DisplayDonors> createState() => _DisplayDonorsState();
}

class _DisplayDonorsState extends State<DisplayDonors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Text("View Donors Here"),
    ]));
  }
}

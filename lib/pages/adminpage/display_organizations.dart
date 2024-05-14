import 'package:flutter/material.dart';

class DisplayOrganizations extends StatefulWidget {
  const DisplayOrganizations({super.key});

  @override
  State<DisplayOrganizations> createState() => _DisplayOrganizationsState();
}

class _DisplayOrganizationsState extends State<DisplayOrganizations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Text("View Organizations Here"),
    ]));
  }
}

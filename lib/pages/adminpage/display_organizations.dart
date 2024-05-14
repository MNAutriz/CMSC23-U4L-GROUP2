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
        backgroundColor: const Color(0xFFEEF2E6),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "View Organizations Here",
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

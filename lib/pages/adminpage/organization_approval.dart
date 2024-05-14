import 'package:flutter/material.dart';

class OrganizationApproval extends StatefulWidget {
  const OrganizationApproval({super.key});

  @override
  State<OrganizationApproval> createState() => _OrganizationApprovalState();
}

class _OrganizationApprovalState extends State<OrganizationApproval> {
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
                    "Organizations for Approval",
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

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
        body: Column(children: [
      Text("View Organizations to be Approved Here"),
    ]));
  }
}

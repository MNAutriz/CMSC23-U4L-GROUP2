import 'package:cmsc23project/pages/adminpage/admin_home.dart';
import 'package:cmsc23project/pages/adminpage/display_donors.dart';
import 'package:cmsc23project/pages/adminpage/display_organizations.dart';
import 'package:cmsc23project/pages/adminpage/organization_approval.dart';
import 'package:flutter/material.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  //indexing for the list of widgets
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    AdminHome(),
    DisplayDonors(),
    DisplayOrganizations(),
    OrganizationApproval(),
  ];

  //function for changing page
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin's View",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1C6758),
        foregroundColor: const Color(0xFFEEF2E6), // Dark green
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1C6758), // Dark green
        selectedItemColor: const Color(0xFFD6CDA4),
        unselectedItemColor: Colors.white.withOpacity(0.6),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Donors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Organizations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.approval),
            label: 'Approvals',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

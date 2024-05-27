import 'package:cmsc23project/pages/donorhomepage/donorhomepage.dart';
import 'package:cmsc23project/pages/donorprofilepage/donor_profile_page.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonorView extends StatefulWidget {
  const DonorView({super.key});

  @override
  State<DonorView> createState() => _DonorViewState();
}

class _DonorViewState extends State<DonorView> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = const [DonorHomePage(), DonorProfilePage()];

    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E6),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF093731),
        selectedItemColor: const Color(0xFFEEF2E6),
        unselectedItemColor: Colors.white.withOpacity(0.6),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Homepage'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

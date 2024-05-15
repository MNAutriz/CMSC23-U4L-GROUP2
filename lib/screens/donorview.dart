import 'package:cmsc23project/pages/donateformpage/donate_form.dart';
import 'package:cmsc23project/pages/donorhomepage/donorhomepage.dart';
import 'package:cmsc23project/pages/donorprofilepage/donor_profile_page.dart';
import 'package:flutter/material.dart';

class DonorView extends StatefulWidget {
  const DonorView({super.key});

  @override
  State<DonorView> createState() => _DonorViewState();
}

class _DonorViewState extends State<DonorView> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {

   List<Widget> pages = const [
    DonorHomePage(),
    DonorProfilePage()
   ];

    //TODO: add search bar
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E6),
      // appBar: AppBar(
      //   title: const Text("Donor's View",
      //       style: TextStyle(color: Color(0xFFEEF2E6), fontWeight: FontWeight.bold)),
      //   backgroundColor: const Color(0xFF093731),
      //   iconTheme: const IconThemeData(color: Color(0xFFEEF2E6)),
      // ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF093731), 
        selectedItemColor: const Color(0xFFEEF2E6),
        unselectedItemColor: Colors.white.withOpacity(0.6),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Homepage'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile'
          ),
        ],
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
    // bottomNavigationBar: BottomNavigationBar(
    //     backgroundColor: const Color(0xFF093731),
    //     selectedItemColor: Colors.white,
    //     unselectedItemColor: Colors.white.withOpacity(0.6),
    //     items: const [
    //       BottomNavigationBarItem(
    //         backgroundColor: Color(0xFF093731),
    //         icon: Icon(Icons.home),
    //         label: 'Home',
    //       ),
    //       BottomNavigationBarItem(
    //         backgroundColor: Color.fromARGB(255, 56, 179, 26),
    //         icon: Icon(Icons.favorite),
    //         label: 'Donate',
    //       ),
    //       BottomNavigationBarItem(
    //           backgroundColor: Color.fromARGB(255, 56, 179, 26),
    //           icon: Icon(Icons.person),
    //           label: "Profile")
    //     ]),
  }
}

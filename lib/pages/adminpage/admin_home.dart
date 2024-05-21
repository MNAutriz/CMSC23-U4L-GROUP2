import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: drawer,
        backgroundColor: const Color(0xFFEEF2E6),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Welcome, Admin!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Color(0xFF1C6758)),
                ),
              ),
            ]));
  }

  //logout
  Drawer get drawer => Drawer(
          child: Container(
        color: const Color(0xFFEEF2E6),
        child: ListView(padding: EdgeInsets.zero, children: [
          const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF1C6758)),
              child: Text("Settings",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color(0xFFEEF2E6)))),
          ListTile(
            title: const Center(
              child: Text(
                "Log out",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF1C6758)),
              ),
            ),
            onTap: () {
              context.read<UserAuthProvider>().signOut();
            },
          ),
        ]),
      ));
}

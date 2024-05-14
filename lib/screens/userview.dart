import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: drawer,
        backgroundColor: const Color(0xFFEEF2E6),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1C6758),
        ),
        body: Align(
          alignment: const AlignmentDirectional(0, 1),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      //sign in as user button
                      SizedBox(
                        width: 350,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/organization');
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3D8361),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            child: const Text(
                              "Sign in as Organization",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),

                      //sign in as donor button
                      SizedBox(
                        width: 350,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/donor');
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3D8361),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            child: const Text(
                              "Sign in as Donor",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      //sign in as admin button
                      SizedBox(
                        width: 350,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/admin');
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3D8361),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            child: const Text(
                              "Sign in as Admin",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  ),
                )
              ]),
        ));
  }

  //logout
  Drawer get drawer => Drawer(
      backgroundColor: const Color(0xFF1C6758),
      child: Container(
        color: const Color(0xFFEEF2E6),
        child: ListView(padding: EdgeInsets.zero, children: [
          const DrawerHeader(
              child: Text("Donation App",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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

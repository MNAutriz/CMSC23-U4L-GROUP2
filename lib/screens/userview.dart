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
            title: const Align(
                alignment: AlignmentDirectional(0, 0),
                child: Text(
                  "CMSC 23 Project",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Outfit',
                      fontSize: 22,
                      letterSpacing: 0),
                ))),
        body: Align(
          alignment: const AlignmentDirectional(0, 1),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //sign in as user button
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signpage');
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3D8361),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    child: const Text(
                      "Sign in as User",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),

                //sign in as admin user button
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3D8361),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    child: const Text(
                      "Sign in as Admin",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                const SizedBox(),
              ]),
        ));
  }

  //logout
  Drawer get drawer => Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
        const DrawerHeader(child: Text("Organization")),
        ListTile(
          title: const Text('Logout'),
          onTap: () {
            context.read<UserAuthProvider>().signOut();
          },
        ),
      ]));
}

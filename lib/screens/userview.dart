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
        backgroundColor: const Color(0xFF1C6758),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1C6758),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Color(0xFFD6CDA4),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            decoration: BoxDecoration(
                color: Color(0xFFEEF2E6),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: Align(
              alignment: const AlignmentDirectional(0, 1),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //sign in as user button
                          SizedBox(
                            height: 150,
                            width: 350,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/organization');
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF3D8361),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 20.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0))),
                                child: const Text("ORGANIZATION",
                                    style: TextStyle(
                                        shadows: [
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 2.0,
                                              offset: Offset(2.0, 2.0))
                                        ],
                                        color: Colors.white,
                                        fontFamily: "Freeman",
                                        fontSize: 30),
                                    textAlign: TextAlign.center)),
                          ),

                          SizedBox(
                            height: 40,
                          ),

                          //sign in as donor button
                          SizedBox(
                            height: 150,
                            width: 350,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/donor');
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF3D8361),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 20.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0))),
                                child: const Text(
                                  "DONOR",
                                  style: TextStyle(
                                      shadows: [
                                        Shadow(
                                            color: Colors.black,
                                            blurRadius: 2.0,
                                            offset: Offset(2.0, 2.0))
                                      ],
                                      color: Colors.white,
                                      fontFamily: "Freeman",
                                      fontSize: 30),
                                  textAlign: TextAlign.center,
                                )),
                          ),

                          SizedBox(
                            height: 40,
                          ),

                          //sign in as admin button
                          SizedBox(
                            height: 150,
                            width: 350,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/admin');
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF3D8361),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 20.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0))),
                                child: const Text("ADMIN",
                                    style: TextStyle(
                                        shadows: [
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 2.0,
                                              offset: Offset(2.0, 2.0))
                                        ],
                                        color: Colors.white,
                                        fontFamily: "Freeman",
                                        fontSize: 30),
                                    textAlign: TextAlign.center)),
                          )
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        ));
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

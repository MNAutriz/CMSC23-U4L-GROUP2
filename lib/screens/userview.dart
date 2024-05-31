import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/providers/admin_provider.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:cmsc23project/providers/donor_provider.dart';
import 'package:cmsc23project/providers/organization_provider.dart';
import 'package:cmsc23project/screens/adminview.dart';
import 'package:cmsc23project/screens/donorview.dart';
import 'package:cmsc23project/screens/orgview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  User? user;

  dynamic admin;
  dynamic org;
  dynamic donor;

  @override
  Widget build(BuildContext context) {
    //get user
    user = context.read<UserAuthProvider>().user;

    //check if user is in the admins database
    context
        .watch<AdminProvider>()
        .admin
        .where("email", isEqualTo: user!.email!)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          //contain query in admin
          admin = doc;
        });
      });
    });

    //check if org
    context
        .watch<OrganizationProvider>()
        .orgCollection
        .where("email", isEqualTo: user!.email!)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          //contain query in admin
          org = doc;
        });
      });
    });

    //check if donor
    context
        .watch<DonorProvider>()
        .donorCollection
        .where("email", isEqualTo: user!.email!)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          //contain query in donor
          donor = doc;
        });
      });
    });

    //if the user is in the admin database
    if (admin != null) {
      return AdminView();
      //if the user is in the organization database
    } else if (org != null) {
      return DonationApp();
    }

    //else return authDonor
    else if (donor != null) {
      return DonorView();
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  Widget get authOrg => //authorized as org widget
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
                    borderRadius: BorderRadius.circular(30.0))),
            child: const Text("ORGANIZATION",
                style: TextStyle(shadows: [
                  Shadow(
                      color: Colors.black,
                      blurRadius: 2.0,
                      offset: Offset(2.0, 2.0))
                ], color: Colors.white, fontFamily: "Freeman", fontSize: 30),
                textAlign: TextAlign.center)),
      );

  Widget get authAdmin => //authorized as admin widget
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
                    borderRadius: BorderRadius.circular(30.0))),
            child: const Text("ADMIN",
                style: TextStyle(shadows: [
                  Shadow(
                      color: Colors.black,
                      blurRadius: 2.0,
                      offset: Offset(2.0, 2.0))
                ], color: Colors.white, fontFamily: "Freeman", fontSize: 30),
                textAlign: TextAlign.center)),
      );

  Widget get authDonor => //authorized as donor widget
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
                    borderRadius: BorderRadius.circular(30.0))),
            child: const Text(
              "DONOR",
              style: TextStyle(shadows: [
                Shadow(
                    color: Colors.black,
                    blurRadius: 2.0,
                    offset: Offset(2.0, 2.0))
              ], color: Colors.white, fontFamily: "Freeman", fontSize: 30),
              textAlign: TextAlign.center,
            )),
      );
}

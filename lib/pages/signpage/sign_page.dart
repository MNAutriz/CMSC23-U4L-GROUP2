import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/pages/signpage/google_donor.dart';
import 'package:cmsc23project/providers/admin_provider.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:cmsc23project/providers/donor_provider.dart';
import 'package:cmsc23project/providers/organization_provider.dart';
import 'package:cmsc23project/screens/userview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'signin_page.dart';

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _HomePageState();
}

class _HomePageState extends State<SignPage> {
  User? user;

  dynamic role;

  @override
  Widget build(BuildContext context) {
    Stream<User?> userStream = context.watch<UserAuthProvider>().userStream;

    //get user
    user = context.watch<UserAuthProvider>().user;
    if (user != null) {
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
            role = doc;
          });
        });
      });

      if (role == null) {
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
              role = doc;
            });
          });
        });
      }
    }

    return StreamBuilder(
        stream: userStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error encountered! ${snapshot.error}"),
              ),
            );
          } else if (!snapshot.hasData) {
            return const SignInPage();
          } else if (user != null && role == null) {
            return const SignInPage();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          // if user is logged in, display the scaffold containing the streambuilder for the todos
          return const UserView();
        });
  }
}

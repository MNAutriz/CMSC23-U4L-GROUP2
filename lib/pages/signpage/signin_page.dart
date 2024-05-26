import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/models/username_model.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:cmsc23project/providers/donor_provider.dart';
import 'package:cmsc23project/providers/organization_provider.dart';
import 'package:cmsc23project/providers/username_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool showSignInErrorMessage = false;
  dynamic userLogin;
  dynamic googleUser;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/sign_image.jpg"), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 300,
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Color(0xFFEEF2E6),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                heading,
                                emailField,
                                passwordField,
                                showSignInErrorMessage
                                    ? signInErrorMessage
                                    : Container(),
                                submitButton,
                                signUpButton,
                                googleSignIn
                              ],
                            ),
                          ))),
                ),
              ],
            )));
  }

  Widget get heading => const Padding(
        padding: EdgeInsets.only(bottom: 30, top: 50),
        child: Text(
          "SIGN IN",
          style: TextStyle(
              fontSize: 40, fontFamily: "Freeman", color: Color(0xFF1C6758)),
        ),
      );

  Widget get emailField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFD6CDA4),
              border: OutlineInputBorder(),
              label: Text("Username"),
              hintText: "Enter your username/email"),
          onSaved: (value) => setState(() => email = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your username/email";
            }
            return null;
          },
        ),
      );

  Widget get passwordField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFD6CDA4),
              border: OutlineInputBorder(),
              label: Text("Password"),
              hintText: "******"),
          obscureText: true,
          onSaved: (value) => setState(() => password = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your password";
            }
            return null;
          },
        ),
      );

  Widget get signInErrorMessage => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          "Invalid email or password",
          style: TextStyle(color: Colors.red),
        ),
      );

  Widget get submitButton => SizedBox(
      width: 350,
      child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              //check if the input is a username that is in the database
              await context
                  .read<UsernameProvider>()
                  .usernameCollection
                  .where("username", isEqualTo: email!)
                  .get()
                  .then((QuerySnapshot querySnapshot) {
                querySnapshot.docs.forEach((doc) {
                  setState(() {
                    //contain the email of the username
                    userLogin = doc['email'];
                  });
                });
              });

              String? message;

              //if the input is not in the username database
              if (userLogin != null) {
                print(userLogin);
                message = await context
                    .read<UserAuthProvider>()
                    .authService
                    .signIn(userLogin, password!);
                //if the username exists
              } else {
                message = await context
                    .read<UserAuthProvider>()
                    .authService
                    .signIn(email!, password!);
              }

              print(message);
              print(showSignInErrorMessage);

              setState(() {
                if (message != null && message.isNotEmpty) {
                  showSignInErrorMessage = true;
                } else {
                  showSignInErrorMessage = false;
                }
              });
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3D8361),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0))),
          child: const Text("Sign in",
              style: TextStyle(
                fontFamily: "Freeman",
                color: Colors.white,
              ))));

  Widget get signUpButton => Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("No account yet?"),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()));
                },
                child: const Text("Sign up",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C6758),
                    )))
          ],
        ),
      );

  Widget get googleSignIn => Center(
          child: Column(
        children: [
          Divider(),
          SizedBox(
              child: ElevatedButton(
            onPressed: () async {
              UserCredential message =
                  await context.read<UserAuthProvider>().signInWithGoogle();

              //check if org
              await context
                  .read<OrganizationProvider>()
                  .orgCollection
                  .where("email", isEqualTo: message.user!.email)
                  .get()
                  .then((QuerySnapshot querySnapshot) {
                querySnapshot.docs.forEach((doc) {
                  setState(() {
                    //contain query in admin
                    googleUser = doc['email'];
                  });
                });
              });

              //check if donor
              await context
                  .read<DonorProvider>()
                  .donorCollection
                  .where("email", isEqualTo: message.user!.email)
                  .get()
                  .then((QuerySnapshot querySnapshot) {
                querySnapshot.docs.forEach((doc) {
                  setState(() {
                    //contain query in donor
                    googleUser = doc['email'];
                  });
                });
              });

              //check if user finished google sign in and if user already exists in either donor or organization
              if (message.user != null && googleUser == null) {
                await Navigator.pushNamed(context, '/google/donor');
              }
            },
            child: Image.asset(
              "images/google-logo.png",
              width: 20,
              height: 20,
            ),
          ))
        ],
      ));
}

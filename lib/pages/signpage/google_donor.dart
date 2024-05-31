import 'package:cmsc23project/models/donor_model.dart';
import 'package:cmsc23project/pages/signpage/google_org.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:cmsc23project/providers/donor_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoogleDonor extends StatefulWidget {
  const GoogleDonor({super.key});

  @override
  State<GoogleDonor> createState() => _SignUpState();
}

class _SignUpState extends State<GoogleDonor> {
  final _formKey = GlobalKey<FormState>();

  String? name;
  String? username;
  String? address;
  String? contact;
  User? user;
  @override
  Widget build(BuildContext context) {
    //get user
    user = context.read<UserAuthProvider>().user;
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E6),
      appBar: AppBar(
          backgroundColor: const Color(0xFF1C6758),
          title: const Align(
            alignment: AlignmentDirectional(0, 0),
          )),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  heading,
                  nameField,
                  addressField,
                  contactField,
                  usernameField,
                  submitButton,
                  signUpOrgButton
                ],
              ),
            )),
      ),
    );
  }

  //header
  Widget get heading => const Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: Center(
        child: Text(
          "ENTER DONOR INFORMATION",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 40, fontFamily: "Freeman", color: Color(0xFF1C6758)),
        ),
      ));

  //complete name field
  Widget get nameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFD6CDA4),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF1C6758), width: 2.0)),
              floatingLabelStyle: TextStyle(color: Color(0xFF1C6758)),
              label: Text("Complete Name"),
              hintText: "Enter your complete name"),
          onSaved: (value) => setState(() => name = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter your complete name";
            }
            return null;
          },
        ),
      );

  //first name field
  Widget get contactField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          //number keyboard only
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFD6CDA4),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF1C6758), width: 2.0)),
              floatingLabelStyle: TextStyle(color: Color(0xFF1C6758)),
              label: Text("Contact Number"),
              hintText: "Enter your contact number"),
          onSaved: (value) => setState(() => contact = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter your contact number";
            }

            //check if the input contact number is an integer
            var check = int.tryParse(value);

            //check if not an integer
            if (check == null) {
              return "Enter a valid contact number";
            }

            //password length
            int cLength = value.length;

            //check if contact number starts in "09"
            var format = value.substring(0, 2);
            if (format != "09") {
              return "Enter your number in the format 09XXXXXXXXX";
            }

            //check if contact number is 11 digits
            if (cLength != 11) {
              return "Enter your 11 digit contact number";
            }

            //no error
            return null;
          },
        ),
      );

  //username field
  Widget get usernameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFD6CDA4),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF1C6758), width: 2.0)),
              floatingLabelStyle: TextStyle(color: Color(0xFF1C6758)),
              label: Text("Username"),
              hintText: "Enter your username"),
          onSaved: (value) => setState(() => username = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter your username";
            }

            int uLength = value.length;

            //too short username
            if (uLength < 6) {
              return "Your username is too short (6 to 30 chars only)";
            }

            //too long username
            if (uLength > 30) {
              return "Your username is too long (6 to 30 chars only)";
            }

            return null;
          },
        ),
      );

  //address field
  Widget get addressField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFD6CDA4),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF1C6758), width: 2.0)),
              floatingLabelStyle: TextStyle(color: Color(0xFF1C6758)),
              label: Text("Address"),
              hintText: "Enter your address"),
          onSaved: (value) => setState(() => address = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter your address";
            }
            return null;
          },
        ),
      );

  //sign up as org button
  Widget get signUpOrgButton => Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Have an organization?"),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GoogleOrganization()));
                },
                child: const Text("Click here",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C6758),
                    )))
          ],
        ),
      );

  //submit button
  Widget get submitButton => SizedBox(
        width: 350,
        child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                //create donor object to save
                Donor donor = Donor(
                    id: user!.uid,
                    email: user!.email!,
                    username: username!,
                    name: name!,
                    address: [address!],
                    contact: contact!);

                context.read<DonorProvider>().addDonor(donor);

                if (mounted) {
                  Navigator.pop(context);
                }
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3D8361),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            child: const Text("Continue as donor",
                style: TextStyle(color: Colors.white, fontFamily: "Freeman"))),
      );
}

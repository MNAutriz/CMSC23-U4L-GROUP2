import 'dart:io';
import 'package:cmsc23project/models/donor_model.dart';
import 'package:cmsc23project/models/organization_model.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:cmsc23project/providers/donor_provider.dart';
import 'package:cmsc23project/providers/pending_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoogleOrganization extends StatefulWidget {
  const GoogleOrganization({super.key});

  @override
  State<GoogleOrganization> createState() => _SignUpAsOrganizationState();
}

class _SignUpAsOrganizationState extends State<GoogleOrganization> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? username;
  String? address;
  String? contact;
  String? organizationName;
  User? user;

  //proof of legitimacy
  PlatformFile? proof;

  //browse file function
  Future browseFile() async {
    //pick file
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    //no file selected
    if (result == null) return;

    //set proof as the selected file
    setState(() {
      proof = result.files.first;
    });
  }

  //upload file to firebase with user's uid as the directory
  Future uploadFile(String email) async {
    final path = 'files/${email}/${proof!.name}';
    final file = File(proof!.path!);

    //upload to firebase
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
  }

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
                  orgNameField,
                  nameField,
                  addressField,
                  contactField,
                  usernameField,
                  uploadProof,
                  submitButton
                ],
              ),
            )),
      ),
    );
  }

  //header
  Widget get heading => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          "ENTER ORGANIZATION INFORMATION",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 40, fontFamily: "Freeman", color: Color(0xFF1C6758)),
        ),
      );

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

  //org name field
  Widget get orgNameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFD6CDA4),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF1C6758), width: 2.0)),
              floatingLabelStyle: TextStyle(color: Color(0xFF1C6758)),
              label: Text("Organization Name"),
              hintText: "Enter your organization name"),
          onSaved: (value) => setState(() => organizationName = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter your organization name";
            }
            return null;
          },
        ),
      );

  //contact field
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

  //submit button
  Widget get submitButton => SizedBox(
        width: 350,
        child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                //no uploaded file
                if (proof == null) {
                  //snackbar containing the error message
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please enter your proof/s of legitimacy"),
                    backgroundColor: Colors.red,
                  ));
                } else {
                  //create organization object for applying
                  Organization org = Organization(
                      id: user!.uid,
                      organizationName: organizationName!,
                      email: user!.email!,
                      username: username!,
                      name: name!,
                      address: address!,
                      contact: contact!);

                  //register as donor initially
                  Donor donor = Donor(
                      id: user!.uid,
                      email: user!.email!,
                      username: username!,
                      name: name!,
                      address: [address!],
                      contact: contact!);

                  //add to pending and donor collection
                  context.read<PendingProvider>().addPending(org);
                  context.read<DonorProvider>().addDonor(donor);

                  //upload pdf file to firebase storage
                  await uploadFile(user!.email!);

                  // check if the widget hasn't been disposed of after an asynchronous action
                  if (mounted) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                }
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3D8361),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            child: const Text("Continue",
                style: TextStyle(color: Colors.white, fontFamily: "Freeman"))),
      );

  //widget for uploading proof/s of legitimacy
  Widget get uploadProof => Column(children: [
        const Text("Upload proofs of legitimacy (PDF)"),
        SizedBox(
            width: 350,
            child: ElevatedButton(
                onPressed: () async {
                  browseFile();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3D8361),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                child: const Text("Browse files",
                    style: TextStyle(
                        color: Colors.white, fontFamily: "Freeman")))),
        SizedBox(
          height: 30,
        )
      ]);
}

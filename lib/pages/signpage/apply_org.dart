import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/models/organization_model.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:cmsc23project/providers/donor_provider.dart';
import 'package:cmsc23project/providers/pending_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplyOrg extends StatefulWidget {
  const ApplyOrg({super.key});

  @override
  State<ApplyOrg> createState() => _ApplyOrgState();
}

class _ApplyOrgState extends State<ApplyOrg> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  User? user;
  dynamic donor;

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
                children: [heading, nameField, submitButton],
              ),
            )),
      ),
    );
  }

  Widget get heading => const Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: Center(
        child: Text(
          "SIGN UP AS AN ORGANIZATION",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 40, fontFamily: "Freeman", color: Color(0xFF1C6758)),
        ),
      ));

  //organization name field
  Widget get nameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFD6CDA4),
              border: OutlineInputBorder(),
              label: Text("Organization Name"),
              hintText: "Enter your organization name"),
          onSaved: (value) => setState(() => name = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your organization name";
            }
            return null;
          },
        ),
      );

  Widget get submitButton => SizedBox(
        width: 350,
        child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                //create new organization object with the fields
                Organization organization =
                    Organization(email: user!.email!, name: name!);

                //add to pending database
                context.read<PendingProvider>().addPending(organization);

                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3D8361),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            child: const Text("Sign up",
                style: TextStyle(color: Colors.white, fontFamily: "Freeman"))),
      );
}

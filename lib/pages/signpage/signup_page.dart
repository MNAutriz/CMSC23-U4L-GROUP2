import 'package:cmsc23project/models/donor_model.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:cmsc23project/providers/donor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? firstName;
  String? lastName;

  @override
  Widget build(BuildContext context) {
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
                  firstNameField,
                  lastNameField,
                  emailField,
                  passwordField,
                  submitButton
                ],
              ),
            )),
      ),
    );
  }

  Widget get heading => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          "SIGN UP",
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
              label: Text("Email"),
              hintText: "Enter a valid email"),
          onSaved: (value) => setState(() => email = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a valid email format";
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
              hintText: "At least 8 characters"),
          obscureText: true,
          onSaved: (value) => setState(() => password = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a valid password";
            } else {
              //password length
              int pLength = value.length;

              if (pLength < 8) {
                return "Please enter a password with at least 8 characters";
              }
            }

            return null;
          },
        ),
      );

  //first name field
  Widget get firstNameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFD6CDA4),
              border: OutlineInputBorder(),
              label: Text("First Name"),
              hintText: "Enter your first name"),
          onSaved: (value) => setState(() => firstName = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your first name";
            }
            return null;
          },
        ),
      );

  //last name field
  Widget get lastNameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFD6CDA4),
              border: OutlineInputBorder(),
              label: Text("Last Name"),
              hintText: "Enter your last name"),
          onSaved: (value) => setState(() => lastName = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your last name";
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

                String? validateEmail = await context
                    .read<UserAuthProvider>()
                    .authService
                    .signUp(email!, password!);

                //if the email is valid
                if (validateEmail == "") {
                  //create user object to save to the database
                  Donor donor = Donor(
                      email: email!,
                      firstName: firstName!,
                      lastName: lastName!);

                  context.read<DonorProvider>().addDonor(donor);

                  // check if the widget hasn't been disposed of after an asynchronous action
                  if (mounted) Navigator.pop(context);
                } else {
                  //snackbar containing the error message
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(validateEmail!),
                    backgroundColor: Colors.red,
                  ));
                }
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

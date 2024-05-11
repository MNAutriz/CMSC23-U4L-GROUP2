import 'package:cmsc23project/pages/donateformpage/fields/donation_type.dart';
import 'package:flutter/material.dart';

class DonateForm extends StatefulWidget {
  const DonateForm({super.key});

  @override
  State<DonateForm> createState() => _DonateFormState();
}

class _DonateFormState extends State<DonateForm> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3D8361),
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        title: const Text("Donation Form", style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white
        ))
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Center(
              child: Text("What would you like to donate?", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              )),
            ),
            Expanded(child: DonationTypeField()),
          ],
        ),
      )
    );
  }
}
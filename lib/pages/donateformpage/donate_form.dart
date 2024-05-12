import 'package:cmsc23project/pages/donateformpage/fields/donation_type.dart';
import 'package:cmsc23project/pages/donateformpage/fields/pickup_field.dart';
import 'package:cmsc23project/pages/donateformpage/fields/weight_field.dart';
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
      backgroundColor: const Color(0xFFEEF2E6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3D8361),
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        title: const Text("Donation Form", style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),)
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF3D8361),
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("What would you like to donate?", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white
                      )),
                    ),
                  ),
                ),
              ),
              DonationTypeField(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF3D8361),
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left:32.0, right: 32, top: 8, bottom: 8),
                    child: Center(
                      child: Text("Would you like your donations picked up?", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ), textAlign: TextAlign.center),
                    ),
                  ),
                ),
              ),
              PickupField(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF3D8361),
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("How heavy are your items?", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ), textAlign: TextAlign.center),
                    ),
                  ),
                ),
              ),
              WeightField(),
            ],
          ),
        ),
      )
    );
  }
}
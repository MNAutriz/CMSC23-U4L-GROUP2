import 'package:cmsc23project/pages/donateformpage/fields/address_field.dart';
import 'package:cmsc23project/pages/donateformpage/fields/contact_no_field.dart';
import 'package:cmsc23project/pages/donateformpage/fields/date_time.dart';
import 'package:cmsc23project/pages/donateformpage/fields/donation_type.dart';
import 'package:cmsc23project/pages/donateformpage/fields/pickup_field.dart';
import 'package:cmsc23project/pages/donateformpage/fields/submit.dart';
import 'package:cmsc23project/pages/donateformpage/fields/upload_photo.dart';
import 'package:cmsc23project/pages/donateformpage/fields/weight_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class DonateForm extends StatefulWidget {
  const DonateForm({super.key});

  @override
  State<DonateForm> createState() => _DonateFormState();
}

class _DonateFormState extends State<DonateForm> {

  final _formKey = GlobalKey<FormState>();
  bool isPickupChecked = false; // initialize here and not on build or else the value will always be false on rebuild

  @override
  Widget build(BuildContext context) {

    // bool isPickupChecked;

    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF093731),
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
              const OneLineQuestion(text: "What would you like to donate?"),
              const DonationTypeField(),
              const TwoLineQuestion(text: "Would you like your donations picked up?"),
              PickupField(
                yesChecked: (){
                  setState(() {
                    isPickupChecked = true;
                  });
                },
                noChecked: (){
                  setState(() {
                    isPickupChecked = false;
                  });
                }
              ),
              const OneLineQuestion(text: "How heavy are your items"),
              const WeightField(),
              const OneLineQuestion(text: "Optional: Upload photo of items"),
              const UploadPhotoButtons(),
              const OneLineQuestion(text: "Date and time for pickup/drop-off"),
              const DateTimeField(),

              // TODO: wrap in visibility widget and base visibility on pickupfield
              
              Visibility(
                visible: isPickupChecked,
                child: const Column(
                  children: [
                    OneLineQuestion(text: "Enter your pickup address"),
                    AddressField(),
                    OneLineQuestion(text: "Please enter your contact number"),
                    ContactNoField(),
                  ],
                ),
              ),
              SubmitForm()
            ],
          ),
        ),
      )
    );
  }
}

class TwoLineQuestion extends StatelessWidget {
  final String text;

  const TwoLineQuestion({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF093731),
          borderRadius: BorderRadius.circular(100)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left:32.0, right: 32, top: 8, bottom: 8),
          child: Center(
            child: Text(text, style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ), textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}

class OneLineQuestion extends StatelessWidget {

  final String text;

  const OneLineQuestion({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF093731),
          borderRadius: BorderRadius.circular(100)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(text , style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white
            )),
          ),
        ),
      ),
    );
  }
}
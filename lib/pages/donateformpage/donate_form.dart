import 'package:cmsc23project/models/donor_form.dart';
import 'package:cmsc23project/pages/donateformpage/fields/address_field.dart';
import 'package:cmsc23project/pages/donateformpage/fields/contact_no_field.dart';
import 'package:cmsc23project/pages/donateformpage/fields/date_time.dart';
import 'package:cmsc23project/pages/donateformpage/fields/donation_type.dart';
import 'package:cmsc23project/pages/donateformpage/fields/pickup_field.dart';
import 'package:cmsc23project/pages/donateformpage/fields/submit.dart';
import 'package:cmsc23project/pages/donateformpage/fields/upload_photo/upload_photo.dart';
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
  DonorForm formData = DonorForm(
    donationTypes: [],
    forPickup: false,
    weight: 0,
    weightUnit: "kg",
    donationPhoto: "",
    donationDate: DateTime.now(),
    donationTime: TimeOfDay.now(),
  );

  @override
  Widget build(BuildContext context) {

    // bool isPickupChecked;

    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF093731),
        iconTheme: const IconThemeData(
          color: Color(0xFFEEF2E6)
        ),
        title: const Text("Donation Form", style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFFEEF2E6)
        ),)
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // TODO: display which org user is donating to at start
              const Header(text: "What would you like to donate?"),
              DonationTypeField(formData: formData, formKey: _formKey),
              const Header(text: "Would you like your donations picked up?"),
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
                },
                formData: formData,
              ),
              const Header(text: "How heavy are your items?"),
              WeightField(formData: formData),
              const Header(text: "If you can, please upload a photo of your items"),
              UploadPhotoButtons(formData: formData),
              Header(text: "When will ${isPickupChecked == true ? "we pickup your" : "you drop-off your"} donation?"),
              DateTimeField(formData: formData),
              Visibility(
                visible: isPickupChecked,
                child: Column(
                  children: [
                    const Header(text: "Where would we pickup your donations?"),
                    AddressField(formData: formData, isPickupChecked: isPickupChecked,),
                    const Header(text: "What number should we reach you at?"),
                    ContactNoField(formData: formData, isPickupChecked: isPickupChecked,),
                  ],
                ),
              ),
              SubmitForm(formKey: _formKey, formData: formData)
            ],
          ),
        ),
      )
    );
  }
}

class Header extends StatelessWidget {

  final String text;

  const Header({
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
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8 ),
          child: Center(
            child: Text(text , style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFFEEF2E6)
            ),
            textAlign: TextAlign.center,),
          ),
        ),
      ),
    );
  }
}
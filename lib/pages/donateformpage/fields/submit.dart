import 'package:cmsc23project/models/donor_form.dart';
import 'package:flutter/material.dart';

class SubmitForm extends StatefulWidget {
  GlobalKey<FormState> formKey;
  DonorForm formData;

  SubmitForm({super.key, required this.formKey, required this.formData});

  @override
  State<SubmitForm> createState() => _SubmitFormState();
}

class _SubmitFormState extends State<SubmitForm> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF093731),
      child: TextButton(
        onPressed: () {
          if (widget.formKey.currentState!.validate()) {
            widget.formKey.currentState!.save(); // trigger onSaved callback of each form field
            debugPrint(
                'Donation Form Successfully Submitted!\nDonation Types: ${widget.formData.donationTypes}\n'
                'For Pickup: ${widget.formData.forPickup}\n'
                'Weight: ${widget.formData.weight} ${widget.formData.weightUnit}\n'
                'Donation Photo: ${widget.formData.donationPhoto}\n'
                'Donation Date and Time: ${widget.formData.donationDateTime}\n'
                'Contact No: ${widget.formData.contactNo}\n'
                'Pickup Addresses: ${widget.formData.pickupAddresses}');
          }
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Submit!",
            style: TextStyle(
              color: Color(0xFFEEF2E6),
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}

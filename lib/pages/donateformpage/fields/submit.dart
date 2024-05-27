import 'package:cmsc23project/models/donor_form.dart';
import 'package:cmsc23project/pages/donateformpage/submitted_page.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:cmsc23project/providers/donor_form_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final donorFormProvider = Provider.of<DonorFormProvider>(context);
    User? user = context.watch<UserAuthProvider>().user;

    return Card(
      color: const Color(0xFF093731),
      child: TextButton(
        onPressed: () async {
          if (widget.formKey.currentState!.validate()) {
            widget.formKey.currentState!
                .save(); // trigger onSaved callback of each form field
            widget.formData.donorEmail = user!.email!;

            final result =
                await donorFormProvider.addForm(widget.formData.toJson());

            // Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => SubmittedPage(formData: widget.formData),
            //   ),
            // );

            // Navigator.pushNamedAndRemoveUntil(context, '/donor', (route) => false);
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

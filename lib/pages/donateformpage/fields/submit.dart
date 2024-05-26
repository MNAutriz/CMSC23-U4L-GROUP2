import 'package:cmsc23project/models/donor_form.dart';
import 'package:flutter/material.dart';

class SubmitForm extends StatelessWidget {

  // GlobalKey<FormState> _formKey;
  DonorForm formData;

  SubmitForm({super.key, required GlobalKey<FormState> formKey, required this.formData}) {
    // _formKey = formKey;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF093731),
      child: TextButton(
        onPressed: () {
          // save data
          // if(widget.formKey.currentState!.validate()) {
            
          // }
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("Submit!", style: TextStyle(color: Color(0xFFEEF2E6), fontWeight: FontWeight.bold, fontSize: 17)),
        )
      ),
      
    );
  }
}

import 'package:cmsc23project/models/donor_form.dart';
import 'package:flutter/material.dart';

class ContactNoField extends StatefulWidget {

  DonorForm formData;
  bool isPickupChecked;

  ContactNoField({super.key, required this.formData, required this.isPickupChecked});

  @override
  State<ContactNoField> createState() => _ContactNoFieldState();
}

class _ContactNoFieldState extends State<ContactNoField> {
  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: '',
      builder: (state) {
        return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "09123456789",
                hintStyle: TextStyle(
                  color: const Color(0xFF3D8361).withOpacity(0.3),
                ),
                labelStyle: const TextStyle(
                  color: Color(0xFF3D8361),
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                state.didChange(value); // notify formfield that value changed
              },
            ),
          )
        ),
      );
      },
      validator: (value) {
        if(widget.isPickupChecked && (value == '' || value == null)){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please enter your contact number'),
            )
          );
          return "Please enter a valid contact address";
        } 
      },
      onSaved: (value) {
        widget.formData.contactNo = value!;
        debugPrint(widget.formData.contactNo);
      },
    );
  }
}
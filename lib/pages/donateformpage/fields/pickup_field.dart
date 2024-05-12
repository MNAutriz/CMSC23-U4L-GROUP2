import 'package:flutter/material.dart';

class PickupField extends StatefulWidget {
  const PickupField({super.key});

  @override
  State<PickupField> createState() => _PickupFieldState();
}

class _PickupFieldState extends State<PickupField> {

  String? checkedValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Card(
            child: RadioListTile(
              title: const Text("Yes"),
              value: "Yes",
              groupValue: checkedValue,
              activeColor: const Color(0xFF3D8361),
              onChanged: (String? value) {
                setState(() {
                  checkedValue = value!;
                });
              },
            )
          ),
        ),
        Flexible(
          child: Card(
            child: RadioListTile(
              title: const Text("No"),
              value: "No",
              groupValue: checkedValue,
              activeColor: const Color(0xFF3D8361),
              onChanged: (String? value) {
                setState(() {
                  checkedValue = value!;
                });
              },
            )
          ),
        )
      ]
    );
  }
}
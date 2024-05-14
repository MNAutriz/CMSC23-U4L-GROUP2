import 'package:flutter/material.dart';

class SubmitForm extends StatelessWidget {
  const SubmitForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF093731),
      child: TextButton(
        onPressed: () {
          // save data
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: const Text("Submit!", style: TextStyle(color: const Color(0xFFEEF2E6), fontWeight: FontWeight.bold, fontSize: 17)),
        )
      ),
      
    );
  }
}
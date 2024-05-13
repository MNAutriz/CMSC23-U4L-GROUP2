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
        child: const Text("Submit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))

      ),
      
    );
  }
}
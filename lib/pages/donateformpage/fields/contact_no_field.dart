import 'package:flutter/material.dart';

class ContactNoField extends StatefulWidget {
  const ContactNoField({super.key});

  @override
  State<ContactNoField> createState() => _ContactNoFieldState();
}

class _ContactNoFieldState extends State<ContactNoField> {
  @override
  Widget build(BuildContext context) {
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
            )
          ),
        )
      ),
    );
  }
}
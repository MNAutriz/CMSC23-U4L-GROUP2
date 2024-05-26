import 'package:flutter/material.dart';

class AddressField extends StatefulWidget {


  const AddressField({super.key});

  @override
  State<AddressField> createState() => _AddressFieldState();
}

class _AddressFieldState extends State<AddressField> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TextFormField(
            minLines: 4,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Address line 1\nAddress line 2\nAddress line 3\nAddress line 4",
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
    // return  Card(
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: TextFormField(
    //               decoration: const InputDecoration(
    //                 label: Text("Enter total weight here"),
    //                 labelStyle: TextStyle(color: Color(0xFF3D8361), fontWeight: FontWeight.bold),
    //                 border: InputBorder.none
    //                 // border: OutlineInputBorder(),
    //               )
    //             ),
    //           ),
    //         ),;
  }
}
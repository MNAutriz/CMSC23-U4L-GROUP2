import 'package:flutter/material.dart';

class WeightField extends StatefulWidget {
  const WeightField({super.key});

  @override
  State<WeightField> createState() => _WeightFieldState();
}

class _WeightFieldState extends State<WeightField> {

  String? selectedUnit = 'kg';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Enter total weight here"),
                    labelStyle: TextStyle(color: Color(0xFF3D8361), fontWeight: FontWeight.bold),
                    border: InputBorder.none
                    // border: OutlineInputBorder(),
                  )
                ),
              ),
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.only(top:16.0, bottom: 16, left: 8, right: 8),
            child: DropdownButton(
              value: selectedUnit,
              items: <String>['kg', 'lbs']
                  .map<DropdownMenuItem>((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value){
                setState(() {
                  selectedUnit = value!;
                });
              }
            ),
          ),
        )
      ]
    );
  }
}
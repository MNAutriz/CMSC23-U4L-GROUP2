import 'package:cmsc23project/models/donor_form.dart';
import 'package:cmsc23project/providers/donor_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeightField extends StatefulWidget {

  DonorForm formData;

  WeightField({super.key, required this.formData});

  @override
  State<WeightField> createState() => _WeightFieldState();
}

class _WeightFieldState extends State<WeightField> {

  String? selectedUnit = 'kg';
  String? weight;

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
                  initialValue: weight,
                  decoration: const InputDecoration(
                    label: Text("Enter total weight here"),
                    labelStyle: TextStyle(color: Color(0xFF3D8361), fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                    // border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(double.tryParse(value!) == null) return "Please enter a valid weight";
                  },
                  onSaved: (value){
                    widget.formData.weight = double.tryParse(value!)!;
                    debugPrint(widget.formData.weight.toString());
                  },
                ),
              ),
            ),
          ),
        ),
        FormField(
          initialValue: selectedUnit,
          builder: (state) {
            return Card(
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
                    selectedUnit = value;
                    widget.formData.weightUnit = value!;
                  });
                }
              ),
            ),
          );
          },
          validator: (value) {
            if(value != 'kg' && value != 'lbs') return "please select at least one weight unit";
            return null;
          },
          onSaved: (value) {
            // widget.formData.weightUnit = value!; // does not update after submitting another time (moved to onChanged)
            debugPrint(widget.formData.weightUnit);
          },
        )
      ]
    );
  }
}
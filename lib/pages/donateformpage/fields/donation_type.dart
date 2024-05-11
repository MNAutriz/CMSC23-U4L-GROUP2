import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DonationTypeField extends StatefulWidget {
  const DonationTypeField({super.key});

  @override
  State<DonationTypeField> createState() => _DonationTypeFieldState();
}

class _DonationTypeFieldState extends State<DonationTypeField> {

  List<String> types = [
    'Food',
    'Clothes',
    'Cash',
    'Necessities',
    'Necessities',
    'Necessities',
  ];

  // map to track checked status
  // "type": false
  Map<String, bool> isCheckedMap = {}; 

  @override
  void initState() {
    super.initState();

    types.forEach((type) {
      isCheckedMap[type] = false;
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: const {},
      builder: (FormFieldState state) {
        return ListView.builder(
    
          itemCount: types.length,
          itemBuilder: (context, index) {
    
            final type = types[index];
    
            return Padding(
              padding:  const EdgeInsets.only(left: 8, right: 8, bottom: 2),
              child: Card(
                clipBehavior: Clip.hardEdge,
                child: CheckboxListTile(
                  title: Text(type, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  value: isCheckedMap[type] ?? false, // if null, default to false
                  tileColor: const Color(0xFF3D8361),
                  activeColor: const Color(0xFF3D8361),
                  onChanged: (bool? value) {
                    setState(() {
                      isCheckedMap[type] = value ?? false; // if null, default to false
                      state.didChange(isCheckedMap); // pass updated map to state
                    });
                  }
                ),
              ),
            );
          },
        );
      }
    );
  }
}
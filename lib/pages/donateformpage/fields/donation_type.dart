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
          shrinkWrap: true, // 
          physics: const NeverScrollableScrollPhysics(),
    
          itemCount: types.length,
          itemBuilder: (context, index) {
    
            final type = types[index];
    
            return Padding(
              padding:  const EdgeInsets.only(left: 8, right: 8, bottom: 2),
              child: Card(
                clipBehavior: Clip.hardEdge,
                child: ListTile(
                  title: Text(
                    type,
                    style: TextStyle(
                      color: isCheckedMap[type] == false ? const Color(0xFF3D8361) : Colors.white,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  tileColor: isCheckedMap[type] == false ? Colors.white : const Color(0xFF3D8361),
                  onTap: () {
                    isCheckedMap[type] = !(isCheckedMap[type] ?? false); // need ?? because nullable expression can't be used as condition
                    state.didChange(isCheckedMap); // pass updated map to state
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
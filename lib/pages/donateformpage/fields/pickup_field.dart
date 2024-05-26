import 'package:cmsc23project/models/donor_form.dart';
import 'package:cmsc23project/providers/donor_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PickupField extends StatefulWidget {
  final Function()? yesChecked;
  final Function()? noChecked;
  DonorForm formData;

  PickupField(
      {super.key, this.yesChecked, this.noChecked, required this.formData});

  @override
  State<PickupField> createState() => _PickupFieldState();
}

class _PickupFieldState extends State<PickupField> {
  String? checkedValue = "No";

  @override
  Widget build(BuildContext context) {
    return FormField(
        initialValue: checkedValue,
        builder: (state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Flexible(
                child: Card(
                    clipBehavior: Clip.hardEdge,
                    color: checkedValue == "Yes"
                        ? const Color(0xFF3D8361)
                        : Colors.white,
                    child: ListTile(
                        title: Text("Yes",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: checkedValue == "Yes"
                                  ? const Color(0xFFEEF2E6)
                                  : const Color(0xFF3D8361),
                            )),
                        tileColor: checkedValue == "Yes"
                            ? const Color(0xFF3D8361)
                            : Colors.white,
                        selected: checkedValue ==
                            "Yes", // will result to true of checkedValue is "Yes"
                        onTap: () {
                          setState(() {
                            checkedValue = "Yes";
                          });
                          widget.yesChecked?.call(); // will call if not null
                        })),
              ),
              Flexible(
                child: Card(
                    clipBehavior: Clip.hardEdge,
                    color: checkedValue == "No"
                        ? const Color(0xFF3D8361)
                        : Colors.white,
                    child: ListTile(
                        title: Text("No",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: checkedValue == "No"
                                  ? const Color(0xFFEEF2E6)
                                  : const Color(0xFF3D8361),
                            )),
                        tileColor: checkedValue == "No"
                            ? const Color(0xFF3D8361)
                            : Colors.white,
                        selected: checkedValue ==
                            "No", // will result to true of checkedValue is "Yes"
                        onTap: () {
                          setState(() {
                            checkedValue = "No";
                          });
                          widget.noChecked?.call(); // will call if not null
                        })),
              ),
            ]),
          );
        },
        onSaved: (value) {
          widget.formData.forPickup = (value == "Yes"); // of value == yes, it will return true else false
          debugPrint(widget.formData.forPickup.toString());
        },
        validator: (value) {
          if(value != "Yes" && value != "No"){
            return 'Please select at least one pickup option';
          } 
          return null;
        }
        );
  }
}

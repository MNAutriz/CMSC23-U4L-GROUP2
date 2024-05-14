import 'package:flutter/material.dart';

class PickupField extends StatefulWidget {

  final Function()? yesChecked;
  final Function()? noChecked;

  const PickupField({super.key, this.yesChecked, this.noChecked});

  @override
  State<PickupField> createState() => _PickupFieldState();
}

class _PickupFieldState extends State<PickupField> {

  String? checkedValue = "No";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(
            child: Card(
              clipBehavior: Clip.hardEdge,
              color: checkedValue == "Yes" ?  const Color(0xFF3D8361) : Colors.white,
              child: ListTile(
                title: Text("Yes", style: TextStyle(fontWeight: FontWeight.bold, color: checkedValue == "Yes" ? Colors.white: const Color(0xFF3D8361),)),
                tileColor: checkedValue == "Yes" ? const Color(0xFF3D8361) : Colors.white,
                selected: checkedValue == "Yes", // will result to true of checkedValue is "Yes"
                onTap: (){
                  setState(() {
                    checkedValue = "Yes";
                  });
                  widget.yesChecked?.call(); // will call if not null
                }
              )
            ),
          ),
          Flexible(
            child: Card(
              clipBehavior: Clip.hardEdge,
              color: checkedValue == "No" ?  const Color(0xFF3D8361) : Colors.white,
              child: ListTile(
                title: Text("No", style: TextStyle(fontWeight: FontWeight.bold, color: checkedValue == "No" ? Colors.white: const Color(0xFF3D8361),)),
                tileColor: checkedValue == "No" ? const Color(0xFF3D8361) : Colors.white,
                selected: checkedValue == "No", // will result to true of checkedValue is "Yes"
                onTap: (){
                  setState(() {
                    checkedValue = "No";
                  });
                  widget.noChecked?.call(); // will call if not null
                }
              )
            ),
          ),
        ]
      ),
    );
  }
}
import 'package:cmsc23project/models/donor_form.dart';
import 'package:flutter/material.dart';

class DateTimeField extends StatefulWidget {

  DonorForm formData;

  DateTimeField({super.key, required this.formData});

  @override
  State<DateTimeField> createState() => DateTimeFieldState();
}

class DateTimeFieldState extends State<DateTimeField> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FormField(
          initialValue: selectedDate,
          builder: (state) {
            return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: TextButton(
                  child: Text("${selectedDate.year} / ${selectedDate.month} / ${selectedDate.day}", style: const TextStyle(
                    color: Color(0xFF3D8361),
                    fontWeight: FontWeight.bold
                  )),
                  onPressed: () async {
                    final DateTime? dateTime = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                      builder:(context, child) {
                        return Theme(
                          data: ThemeData(
                            colorScheme: const ColorScheme.light(
                              primary: Color(0xFF3D8361),
                              // onPrimary: Colors.yellow,
                            ).copyWith()
                          ),
                          child: child!
                        );
                      },
                    );
                    if(dateTime != null) {
                      setState(() {
                        selectedDate = dateTime;
                        widget.formData.donationDate = selectedDate;
                        debugPrint(selectedDate.toString());
                      });
                    }
                  }
                ),
              ),
            ),
          );
        },
        onSaved: (value) {
          // widget.formData.donationDate = value!;
          debugPrint(widget.formData.donationDate.toString());
        }
        ),
        FormField(
          initialValue: selectedTime,
          builder: (state) {
            return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: TextButton( // padLeft so that time would be 2:09 not 2:9 // will pad 0 to the left if string length less than 2
                  child: Text("${selectedTime.hourOfPeriod}:${selectedTime.minute.toString().padLeft(2,'0')} ${selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}", style: const TextStyle(
                    color: Color(0xFF3D8361),
                    fontWeight: FontWeight.bold,
                  )),
                  onPressed: () async {
                    final TimeOfDay? timeOfDay = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                      initialEntryMode: TimePickerEntryMode.dial,
                      builder: (context, child) => Theme(
                        data: ThemeData(
                          colorScheme: const ColorScheme.light(
                            primary: Color(0xFF3D8361),
                            tertiary: Color(0xFF3D8361),
                            onTertiary: Colors.white
                          )
                        ).copyWith(),
                        child: child!
                      )
                    );
              
                    if(timeOfDay != null) {
                      setState(() {
                        selectedTime = timeOfDay;
                        widget.formData.donationTime = selectedTime;
                        debugPrint(timeOfDay.toString());
                    });
                    }
                  }
                )
              ),
            ),
          );
          },
          onSaved: (value) {
            // widget.formData.donationTime = value!; 
            debugPrint(widget.formData.donationTime.toString());
          },
        )
      ],
    );
  }
}

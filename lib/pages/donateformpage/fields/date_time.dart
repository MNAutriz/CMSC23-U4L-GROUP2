import 'package:cmsc23project/models/donor_form.dart';
import 'package:flutter/material.dart';

class DateTimeField extends StatefulWidget {
  final DonorForm formData;

  DateTimeField({Key? key, required this.formData}) : super(key: key);

  @override
  State<DateTimeField> createState() => DateTimeFieldState();
}

class DateTimeFieldState extends State<DateTimeField> {
  DateTime selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormField<DateTime>(
              initialValue: selectedDateTime,
              builder: (state) {
                return Card(
                  child: TextButton(
                    onPressed: () async {
                      final DateTime? dateTime = await showDatePicker(
                        context: context,
                        initialDate: selectedDateTime,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData(
                              colorScheme: const ColorScheme.light(
                                primary: Color(0xFF3D8361),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (dateTime != null) {
                        setState(() {
                          selectedDateTime = DateTime(
                            dateTime.year,
                            dateTime.month,
                            dateTime.day,
                            selectedDateTime.hour,
                            selectedDateTime.minute,
                          );
                          widget.formData.donationDateTime = selectedDateTime;
                          state.didChange(selectedDateTime);
                          debugPrint(selectedDateTime.toString());
                        });
                      }
                    },
                    child: Text(
                      "${selectedDateTime.year} / ${selectedDateTime.month} / ${selectedDateTime.day}",
                      style: const TextStyle(
                        color: Color(0xFF3D8361),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormField<DateTime>(
              initialValue: selectedDateTime,
              builder: (state) {
                return Card(
                  child: TextButton(
                    onPressed: () async {
                      final TimeOfDay? timeOfDay = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(
                          hour: selectedDateTime.hour,
                          minute: selectedDateTime.minute,
                        ),
                        initialEntryMode: TimePickerEntryMode.dial,
                        builder: (context, child) => Theme(
                          data: ThemeData(
                            colorScheme: const ColorScheme.light(
                              primary: Color(0xFF3D8361),
                              tertiary: Color(0xFF3D8361),
                              onTertiary: Colors.white,
                            ),
                          ),
                          child: child!,
                        ),
                      );

                      if (timeOfDay != null) {
                        setState(() {
                          selectedDateTime = DateTime(
                            selectedDateTime.year,
                            selectedDateTime.month,
                            selectedDateTime.day,
                            timeOfDay.hour,
                            timeOfDay.minute,
                          );
                          widget.formData.donationDateTime = selectedDateTime;
                          state.didChange(selectedDateTime);
                          debugPrint(selectedDateTime.toString());
                        });
                      }
                    },
                    child: Text(
                      "${formatHour(selectedDateTime.hour)}:${selectedDateTime.minute.toString().padLeft(2, '0')} ${selectedDateTime.hour >= 12 ? 'PM' : 'AM'}",
                      style: const TextStyle(
                        color: Color(0xFF3D8361),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
              onSaved: (value) {
                debugPrint(value.toString());
              },
            ),
          ),
        ),
      ],
    );
  }

  String formatHour(int hour) {
    if (hour == 0) {
      return '12';
    } else if (hour > 12) {
      return (hour - 12).toString();
    } else {
      return hour.toString();
    }
  }
}

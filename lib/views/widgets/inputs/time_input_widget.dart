import 'package:flutter/material.dart';
import 'package:my_task_diary/libraries/dates_library.dart';
import 'package:my_task_diary/libraries/themes_library.dart';

class TimeInputWidget extends StatelessWidget {
  final TextEditingController timeController;
  final TimeOfDay currentTime;
  final Function(int epoch) onSave;

  const TimeInputWidget({
    super.key,
    required this.timeController,
    required this.currentTime,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: ThemesLibrary.kTextStyleInputDecoration,
        onSaved: (newValue) => onSave(DatesLibrary.getEpochFromTimeString(time: newValue!)),
        validator: (value) {
          if ((value == null) || (value.trim().isEmpty)) return "Entrez une heure!";
          return null;
        },
        readOnly: true,
        controller: timeController,
        decoration: InputDecoration(
          labelText: "Heure:",
          suffixIcon: IconButton(
            onPressed: () async {
              await showTimePicker(
                initialTime: currentTime,
                barrierDismissible: false,
                initialEntryMode: TimePickerEntryMode.dialOnly,
                context: context,
              ).then(
                (value) {
                  if (value != null) {
                    timeController.text = DatesLibrary.getTimeStringFromTimeOfDay(time: value);
                  }
                },
              );
            },
            icon: const Icon(Icons.access_time, color: ThemesLibrary.kColorDefaultPrimary),
          ),
        ),
      ),
    );
  }
}

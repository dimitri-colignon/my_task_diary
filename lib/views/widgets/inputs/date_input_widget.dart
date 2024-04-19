import 'package:flutter/material.dart';
import 'package:my_task_diary/libraries/applications_library.dart';
import 'package:my_task_diary/libraries/dates_library.dart';
import 'package:my_task_diary/libraries/themes_library.dart';

class DateInputWidget extends StatelessWidget {
  final TextEditingController dateController;
  final DateTime currentDate;
  final Function(int epoch) onSave;

  const DateInputWidget({
    super.key,
    required this.dateController,
    required this.currentDate,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: ThemesLibrary.kTextStyleInputDecoration,
        onSaved: (newValue) => onSave(DatesLibrary.getEpochFromDateString(date: newValue!)),
        validator: (value) {
          if ((value == null) || (value.trim().isEmpty)) return "Entrez une date!";
          return null;
        },
        readOnly: true,
        controller: dateController,
        decoration: InputDecoration(
          labelText: "Date:",
          suffixIcon: IconButton(
            onPressed: () async {
              await showDatePicker(
                currentDate: currentDate,
                initialDate: currentDate,
                firstDate: DateTime.now().subtract(const Duration(days: 70)),
                lastDate: DateTime(DateTime.now().year + 2),
                locale: ApplicationsLibrary.kLocale,
                barrierDismissible: false,
                initialEntryMode: DatePickerEntryMode.calendarOnly,
                context: context,
              ).then(
                (value) {
                  if (value != null) {
                    dateController.text = DatesLibrary.getDateStringFromDateTime(date: value);
                  }
                },
              );
            },
            icon: const Icon(Icons.date_range, color: ThemesLibrary.kColorDefaultPrimary),
          ),
        ),
      ),
    );
  }
}

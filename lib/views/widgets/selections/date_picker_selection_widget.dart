import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:my_task_diary/libraries/applications_library.dart';
import 'package:my_task_diary/libraries/themes_library.dart';
import 'package:my_task_diary/providers/interface_provider.dart';
import 'package:provider/provider.dart';

class DatePickerSelectionWidget extends StatefulWidget {
  const DatePickerSelectionWidget({super.key});

  @override
  State<DatePickerSelectionWidget> createState() => _DatePickerSelectionWidgetState();
}

class _DatePickerSelectionWidgetState extends State<DatePickerSelectionWidget> {
  final DatePickerController _controllerDatePicker = DatePickerController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _controllerDatePicker.animateToSelection());
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [ThemesLibrary.kBoxShadow],
        color: ThemesLibrary.kColorDefaultGrey,
      ),
      child: DatePicker(
        DateTime.now().subtract(const Duration(days: 70)),
        height: 90.0,
        initialSelectedDate: context.watch<InterfaceProvider>().datePickerSelectedDate,
        selectionColor: ThemesLibrary.kColorDefaultPrimary,
        selectedTextColor: ThemesLibrary.kColorDefaultOnPrimary,
        daysCount: 365,
        locale: ApplicationsLibrary.kLocale.languageCode,
        controller: _controllerDatePicker,
        onDateChange: (date) => context.read<InterfaceProvider>().changeDatePickerSelectedDate(date),
      ),
    );
  }
}

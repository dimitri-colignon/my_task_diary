import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_task_diary/libraries/applications_library.dart';

class DatesLibrary {
  DatesLibrary._();

  // *** DATE ***
  // Converti une DateTime en une Date en String avec les heures, minutes, secondes à 0.
  static String getDateStringFromDateTime({required DateTime date}) {
    return DateFormat.yMd(ApplicationsLibrary.kLocale.languageCode).format(date);
  }

  // Converti une DateTime en Epoch avec les heures, minutes, secondes à 0.
  static int getEpochFromDateTime({required DateTime date}) {
    DateTime dateDateTime = DateFormat.yMd(ApplicationsLibrary.kLocale.languageCode).parse(getDateStringFromDateTime(date: date));
    return dateDateTime.millisecondsSinceEpoch;
  }

  // Converti une Date String en Epoch avec les heures, minutes, secondes à 0.
  static int getEpochFromDateString({required String date}) {
    return DateFormat.yMd(ApplicationsLibrary.kLocale.languageCode).parse(date).millisecondsSinceEpoch;
  }

  // Converti un int Epoch en string "yyyy/MM/dd"
  static String getDateStringFromEpoch({required int epoch}) {
    return DateFormat("yyyy/MM/dd").format(DateTime.fromMillisecondsSinceEpoch(epoch));
  }

  // *** HEURE ***
  // Converti un TimeOfDay en un Time en String "hh:mm".
  static String getTimeStringFromTimeOfDay({required TimeOfDay time}) {
    return "${time.hour}:${time.minute}";
  }

  // Converti un Time en String "hh:mm" en Epoch
  static int getEpochFromTimeString({required String time}) {
    return DateFormat("HH:mm").parse(time).millisecondsSinceEpoch;
  }

  // Converti un int Epoch en string hh:mm
  static String getTimeStringFromEpoch({required int epoch}) {
    return DateFormat("HH:mm").format(DateTime.fromMillisecondsSinceEpoch(epoch));
  }

  // *** DATE + HEURE ***
  // Converti une date et time epoch en string
  static String getFullDateAndTimeStringFromEpoch({required int dateEpoch, required int timeEpoch}) {
    return "${getDateStringFromEpoch(epoch: dateEpoch)} ${getTimeStringFromEpoch(epoch: timeEpoch)}";
  }
}

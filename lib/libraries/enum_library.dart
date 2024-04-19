import 'package:flutter/material.dart';
import 'package:my_task_diary/libraries/themes_library.dart';

// *** Priorité des tâches.
enum TypeTaskPriority {
  typeBig(title: "Priorité haute", color: ThemesLibrary.kColorDefaultRed),
  typeNormal(title: "Priorité normale", color: ThemesLibrary.kColorDefaultOrange),
  typeLittle(title: "Priorité faible", color: ThemesLibrary.kColorDefaultGreen);

  final String title;
  final Color color;

  const TypeTaskPriority({
    required this.title,
    required this.color,
  });
}

// *** Type de messages pour les "SnackBar" ou "Dialog".
enum TypeMessage {
  typeInformation(title: "INFORMATION", color: ThemesLibrary.kColorDefaultGreen),
  typeError(title: "ERREUR!", color: ThemesLibrary.kColorDefaultRed);

  final String title;
  final Color color;

  const TypeMessage({
    required this.title,
    required this.color,
  });
}

import 'package:flutter/material.dart';
import 'package:my_task_diary/libraries/extensions_library.dart';
import 'package:my_task_diary/libraries/themes_library.dart';

class TitleInputWidget extends StatelessWidget {
  final TextEditingController titleController;
  final Function(String title) onSave;

  const TitleInputWidget({
    super.key,
    required this.titleController,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: ThemesLibrary.kTextStyleInputDecoration,
        onSaved: (newValue) => onSave(newValue!.capitalize()),
        validator: (value) {
          if ((value == null) || (value.trim().isEmpty)) return "Entrez un titre!";
          return null;
        },
        maxLength: 25,
        controller: titleController,
        decoration: const InputDecoration(
          labelText: "Titre:",
          counterText: "",
        ),
      ),
    );
  }
}

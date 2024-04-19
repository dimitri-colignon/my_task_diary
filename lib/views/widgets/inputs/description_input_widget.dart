import 'package:flutter/material.dart';
import 'package:my_task_diary/libraries/themes_library.dart';

class DescriptionInputWidget extends StatelessWidget {
  final TextEditingController descriptionController;
  final Function(String description) onSave;

  const DescriptionInputWidget({
    super.key,
    required this.descriptionController,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: ThemesLibrary.kTextStyleInputDecoration,
        onSaved: (newValue) => onSave(newValue!),
        validator: (value) {
          if ((value == null) || (value.trim().isEmpty)) return "Entrez une description!";
          return null;
        },
        maxLength: 255,
        maxLines: 5,
        controller: descriptionController,
        decoration: const InputDecoration(
          alignLabelWithHint: true,
          labelText: "Description:",
          counterText: "",
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_task_diary/libraries/enum_library.dart';
import 'package:my_task_diary/libraries/themes_library.dart';

class PriorityDropdownSelectionWidget extends StatelessWidget {
  final int currentPriority;
  final Function(int priority) onSave;

  const PriorityDropdownSelectionWidget({
    super.key,
    required this.currentPriority,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<TypeTaskPriority>(
        value: TypeTaskPriority.values[currentPriority],
        onSaved: (newValue) => onSave(newValue!.index),
        validator: (value) {
          if (value == null) return "Entrez une priorité!";
          return null;
        },
        items: TypeTaskPriority.values.map((TypeTaskPriority typeTaskPriority) {
          return DropdownMenuItem(
            value: typeTaskPriority,
            child: Row(
              children: [
                Container(
                  width: 15.0,
                  height: 15.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90.0),
                    color: typeTaskPriority.color,
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(typeTaskPriority.title, style: ThemesLibrary.kTextStyleInputDecoration),
              ],
            ),
          );
        }).toList(),
        onChanged: (TypeTaskPriority? value) {},
        decoration: const InputDecoration(
          labelText: "Priorité:",
        ),
        icon: const Icon(Icons.arrow_drop_down, color: ThemesLibrary.kColorDefaultPrimary),
      ),
    );
  }
}

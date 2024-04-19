import 'package:flutter/material.dart';
import 'package:my_task_diary/libraries/themes_library.dart';
import 'package:my_task_diary/models/task_model.dart';

void detailsTask({required BuildContext context, required TaskModel task}) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    builder: (BuildContext context) {
      return SizedBox(
        height: 250,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(task.tmpDateTitle, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 10.0),
              Text(task.description, style: const TextStyle(fontSize: 13.0, fontStyle: FontStyle.italic)),
              const SizedBox(height: 15.0),
              SizedBox(
                width: 140.0,
                child: FilledButton(
                  style: ThemesLibrary.kFilledButton,
                  onPressed: () => Navigator.pop(context),
                  child: const Text("FERMER"),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:my_task_diary/libraries/themes_library.dart';

class EmptyDataMessageWidget extends StatelessWidget {
  const EmptyDataMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      alignment: Alignment.center,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Il n'y a pas de tâche dans cette liste!",
            style: TextStyle(color: ThemesLibrary.kColorDefaultRed, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

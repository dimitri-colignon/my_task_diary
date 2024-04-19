import 'package:flutter/material.dart';
import 'package:my_task_diary/libraries/enum_library.dart';
import 'package:my_task_diary/libraries/extensions_library.dart';
import 'package:my_task_diary/libraries/themes_library.dart';

// !!! A adapter pour ios.

class MessagesLibrary {
  MessagesLibrary._();

  // SnackBar.
  static void showSnackBar({required BuildContext context, TypeMessage typeMessage = TypeMessage.typeInformation, required String message}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: typeMessage.color,
        content: Text(message.capitalize(), style: const TextStyle(color: ThemesLibrary.kColorDefaultOnPrimary, fontWeight: FontWeight.w700)),
        showCloseIcon: true,
        closeIconColor: ThemesLibrary.kColorDefaultOnPrimary,
      ),
    );
  }

  // Validation boîte de message.
  static Future<bool> showDialogAlert({required BuildContext context, required Widget child}) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              title: const Text("QUESTION?"),
              content: child,
              actions: [
                FilledButton(
                  style: ThemesLibrary.kFilledButton,
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("OK", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                FilledButton(
                  style: ThemesLibrary.kFilledButton,
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("ANNULER", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            )).then((exit) {
      if (exit == null) return false;
      return exit;
    });
  }

  // Simple boîte de message.
  static Future<void> showDialogSimple({required BuildContext context, required TypeMessage typeMessage, required Widget child}) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => SimpleDialog(
        title: Text(typeMessage.title),
        contentPadding: const EdgeInsets.all(20.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: child,
          ),
          const SizedBox(height: 10.0),
          Center(
            child: FilledButton(
              style: ThemesLibrary.kFilledButton,
              onPressed: () => Navigator.pop(context),
              child: const Text("OK", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

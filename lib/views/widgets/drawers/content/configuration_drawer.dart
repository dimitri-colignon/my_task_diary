import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_task_diary/libraries/messages_library.dart';
import 'package:my_task_diary/libraries/themes_library.dart';
import 'package:my_task_diary/providers/tasks_provider.dart';
import 'package:my_task_diary/views/widgets/drawers/interface/header_drawer.dart';
import 'package:provider/provider.dart';

class ConfigurationDrawer extends StatelessWidget {
  const ConfigurationDrawer({super.key});

  void _deleteAllTasksFromTrash({required BuildContext context}) async {
    if (await MessagesLibrary.showDialogAlert(context: context, child: const Text("Voulez-vous supprimer définitivement le contenu de la corbeille?")) == true) {
      if (!context.mounted) return;
      EasyLoading.show(status: "Supression de la corbeille ...");
      int result = await context.read<TasksProvider>().deleteAllTasksFromTrash();
      if (!context.mounted) return;
      EasyLoading.dismiss();
      MessagesLibrary.showSnackBar(context: context, message: "Le contenu de la corbeille est vidée - $result tâche(s)!");
      Navigator.pop(context);
    }
  }

  void _restaureAllTasksFromTrash({required BuildContext context}) async {
    if (await MessagesLibrary.showDialogAlert(context: context, child: const Text("Voulez-vous restaurer tout le contenu de la corbeille?")) == true) {
      if (!context.mounted) return;
      EasyLoading.show(status: "Restauration de la corbeille ...");
      int result = await context.read<TasksProvider>().restaureAllTasksFromTrash();
      if (!context.mounted) return;
      EasyLoading.dismiss();
      MessagesLibrary.showSnackBar(context: context, message: "Le contenu de la corbeille est restaurée - $result tâche(s)!");
      Navigator.pop(context);
    }
  }

  void _putAllTaskBeforeNowOnTrash({required BuildContext context}) async {
    if (await MessagesLibrary.showDialogAlert(context: context, child: const Text("Voulez-vous mettre les tâches avant la date du jour dans la corbeille?")) == true) {
      if (!context.mounted) return;
      EasyLoading.show(status: "Envoi dans la corbeille ...");
      int result = await context.read<TasksProvider>().putAllTaskBeforeNowOnTrash();
      if (!context.mounted) return;
      EasyLoading.dismiss();
      MessagesLibrary.showSnackBar(context: context, message: "Les tâches avant la date du jour sont dans la corbeille - $result tâche(s)!");
      Navigator.pop(context);
    }
  }

  void _putAllClosedTaskOnTrash({required BuildContext context}) async {
    if (await MessagesLibrary.showDialogAlert(context: context, child: const Text("Voulez-vous mettre les tâches fermées dans la corbeille?")) == true) {
      if (!context.mounted) return;
      EasyLoading.show(status: "Envoi dans la corbeille ...");
      int result = await context.read<TasksProvider>().putAllClosedTaskOnTrash();
      if (!context.mounted) return;
      EasyLoading.dismiss();
      MessagesLibrary.showSnackBar(context: context, message: "Les tâches fermées sont dans la corbeille - $result tâche(s)!");
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width - 30.0,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const HeaderDrawer(title: "Configuration"),
          ListTile(
            title: const Text("Vider la corbeille"),
            subtitle: const Text(
              "Supprimer définitivement le contenu de la corbeille!",
              style: ThemesLibrary.kTextStyleSubTitleDrawer,
            ),
            trailing: IconButton(
              icon: const FaIcon(FontAwesomeIcons.trash, color: ThemesLibrary.kColorDefaultPrimary),
              onPressed: () => _deleteAllTasksFromTrash(context: context),
            ),
            isThreeLine: true,
          ),
          ListTile(
            title: const Text("Restaurer la corbeille"),
            subtitle: const Text(
              "Restaurer tout le contenu de la corbeille!",
              style: ThemesLibrary.kTextStyleSubTitleDrawer,
            ),
            trailing: IconButton(
              icon: const FaIcon(FontAwesomeIcons.trashCanArrowUp, color: ThemesLibrary.kColorDefaultPrimary),
              onPressed: () => _restaureAllTasksFromTrash(context: context),
            ),
            isThreeLine: true,
          ),
          const Divider(),
          ListTile(
            title: const Text("Tâches dépassées"),
            subtitle: const Text(
              "Mettre les tâches avant la date du jour dans la corbeille!",
              style: ThemesLibrary.kTextStyleSubTitleDrawer,
            ),
            trailing: IconButton(
              icon: const FaIcon(FontAwesomeIcons.fileImport, color: ThemesLibrary.kColorDefaultPrimary),
              onPressed: () => _putAllTaskBeforeNowOnTrash(context: context),
            ),
            isThreeLine: true,
          ),
          ListTile(
            title: const Text("Tâches fermées"),
            subtitle: const Text(
              "Mettre les tâches fermées dans la corbeille!",
              style: ThemesLibrary.kTextStyleSubTitleDrawer,
            ),
            trailing: IconButton(
              icon: const FaIcon(FontAwesomeIcons.fileImport, color: ThemesLibrary.kColorDefaultPrimary),
              onPressed: () => _putAllClosedTaskOnTrash(context: context),
            ),
            isThreeLine: true,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_task_diary/libraries/dates_library.dart';
import 'package:my_task_diary/libraries/enum_library.dart';
import 'package:my_task_diary/libraries/messages_library.dart';
import 'package:my_task_diary/libraries/themes_library.dart';
import 'package:my_task_diary/models/task_model.dart';
import 'package:my_task_diary/providers/tasks_provider.dart';
import 'package:my_task_diary/views/tools/tasks_tools.dart';
import 'package:provider/provider.dart';

class TaskFavoriteCardWidget extends StatelessWidget {
  final TaskModel task;

  const TaskFavoriteCardWidget({
    super.key,
    required this.task,
  });

  void _favoriteData({required BuildContext context}) async {
    if (await MessagesLibrary.showDialogAlert(context: context, child: const Text("Voulez-vous enlever cette tâche des favoris?")) == true) {
      if (!context.mounted) return;
      EasyLoading.show(status: "Supression des favoris ...");
      bool result = await context.read<TasksProvider>().manageOneFavorisTask(map: task);
      if (!context.mounted) return;
      EasyLoading.dismiss();
      if (result == false) {
        MessagesLibrary.showSnackBar(context: context, message: "Erreur lors de la suppression des favoris!", typeMessage: TypeMessage.typeError);
      } else {
        MessagesLibrary.showSnackBar(context: context, message: "La tâche n'est plus dans les favoris!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ThemesLibrary.kColorDefaultGrey,
      surfaceTintColor: ThemesLibrary.kColorDefaultGrey,
      child: ListTile(
        title: Text(
          DatesLibrary.getFullDateAndTimeStringFromEpoch(dateEpoch: task.dateTask, timeEpoch: task.timeTask),
          style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          task.title,
          style: const TextStyle(fontSize: 13.0, fontStyle: FontStyle.italic),
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
          tooltip: "Détail de la tâche",
          icon: const FaIcon(FontAwesomeIcons.caretDown),
          onPressed: () => detailsTask(context: context, task: task),
        ),
        trailing: IconButton(
          tooltip: "Enlever des favoris",
          icon: const FaIcon(FontAwesomeIcons.solidHeart, color: ThemesLibrary.kColorDefaultRed),
          onPressed: () => _favoriteData(context: context),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_task_diary/libraries/enum_library.dart';
import 'package:my_task_diary/libraries/messages_library.dart';
import 'package:my_task_diary/libraries/themes_library.dart';
import 'package:my_task_diary/models/task_model.dart';
import 'package:my_task_diary/providers/tasks_provider.dart';
import 'package:my_task_diary/views/tools/tasks_tools.dart';
import 'package:my_task_diary/views/widgets/forms/tasks_form_widget.dart';
import 'package:provider/provider.dart';

class TaskActivedCardWidget extends StatelessWidget {
  final TaskModel task;

  const TaskActivedCardWidget({
    super.key,
    required this.task,
  });

  void _updateData({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      constraints: BoxConstraints.tight(Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.9)),
      builder: (ctx) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: TasksFormWidget(task: task),
          ),
        );
      },
    );
  }

  void _deleteData({required BuildContext context}) async {
    if (await MessagesLibrary.showDialogAlert(context: context, child: const Text("Voulez-vous supprimer cette tâche?")) == true) {
      if (!context.mounted) return;
      EasyLoading.show(status: "Suppression de la tâche ...");
      bool result = await context.read<TasksProvider>().manageOneTrashTask(map: task);
      if (!context.mounted) return;
      EasyLoading.dismiss();
      if (result == false) {
        MessagesLibrary.showSnackBar(context: context, message: "Erreur lors de la suppression de la tâche!", typeMessage: TypeMessage.typeError);
      } else {
        MessagesLibrary.showSnackBar(context: context, message: "La tâche est supprimée!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color taskPriority = TypeTaskPriority.values[task.priority].color;
    return Container(
      width: double.maxFinite,
      height: 90.0,
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: taskPriority, width: 5.0),
        ),
        borderRadius: BorderRadius.circular(12.0),
        color: ThemesLibrary.kColorDefaultGrey,
        boxShadow: const [ThemesLibrary.kBoxShadow],
      ),
      child: SizedBox(
        width: double.maxFinite,
        height: 90.0,
        child: Stack(
          children: [
            Positioned(
              left: 10.0,
              top: 10.0,
              right: 30.0,
              child: Text(
                task.tmpDateTitle,
                style: const TextStyle(fontWeight: FontWeight.w700),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (task.favorite)
              Positioned(
                top: 0.0,
                right: 35.0,
                child: Container(
                  width: 20.0,
                  height: 40.0,
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.fromLTRB(2.5, 22.5, 2.5, 2.5),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(45.0),
                      bottomRight: Radius.circular(45.0),
                    ),
                    color: ThemesLibrary.kColorDefaultRed,
                  ),
                  child: Tooltip(
                    message: "Tâche favorite!",
                    child: Container(
                      width: 15.0,
                      height: 15.0,
                      padding: const EdgeInsets.all(1.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45.0),
                        color: ThemesLibrary.kColorDefaultOnPrimary,
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: ThemesLibrary.kColorDefaultRed,
                        size: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
            Positioned(
              top: 0.0,
              right: 10.0,
              child: Container(
                width: 20.0,
                height: 40.0,
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.fromLTRB(2.5, 22.5, 2.5, 2.5),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(45.0),
                    bottomRight: Radius.circular(45.0),
                  ),
                  color: (task.actived == true) ? ThemesLibrary.kColorDefaultGreen : ThemesLibrary.kColorDefaultRed,
                ),
                child: Tooltip(
                  message: (task.actived == true) ? "Tâche ouverte!" : "Tâche fermée!",
                  child: Container(
                    width: 15.0,
                    height: 15.0,
                    padding: const EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45.0),
                      color: ThemesLibrary.kColorDefaultOnPrimary,
                    ),
                    child: (task.actived == true)
                        ? const Icon(
                            Icons.check,
                            color: ThemesLibrary.kColorDefaultGreen,
                            size: 12.0,
                          )
                        : const Icon(
                            Icons.close,
                            color: ThemesLibrary.kColorDefaultRed,
                            size: 12.0,
                          ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              top: 50.0,
              bottom: 0.0,
              child: Container(
                width: 150.0,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: taskPriority, width: 3.0),
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(45.0),
                    bottomRight: Radius.circular(45.0),
                  ),
                  color: taskPriority.withOpacity(0.05),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () => detailsTask(context: context, task: task),
                      icon: const FaIcon(
                        FontAwesomeIcons.noteSticky,
                        color: ThemesLibrary.kColorDefaultBlack,
                        size: 20.0,
                      ),
                      tooltip: "Description!",
                    ),
                    IconButton(
                      onPressed: () => _updateData(context: context),
                      icon: const FaIcon(
                        FontAwesomeIcons.penToSquare,
                        color: ThemesLibrary.kColorDefaultBlack,
                        size: 20.0,
                      ),
                      tooltip: "Modifier!",
                    ),
                    IconButton(
                      onPressed: () => _deleteData(context: context),
                      icon: const FaIcon(
                        FontAwesomeIcons.trashCan,
                        color: ThemesLibrary.kColorDefaultRed,
                        size: 20.0,
                      ),
                      tooltip: "Supprimer!",
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 70.0,
              right: 10.0,
              child: Text(
                TypeTaskPriority.values[task.priority].title,
                style: const TextStyle(fontSize: 10.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

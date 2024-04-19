import 'package:flutter/material.dart';
import 'package:my_task_diary/models/task_model.dart';
import 'package:my_task_diary/providers/tasks_provider.dart';
import 'package:my_task_diary/views/widgets/cards/task_deleted_card_widget.dart';
import 'package:my_task_diary/views/widgets/messages/empty_data_message_widget.dart';
import 'package:provider/provider.dart';

class TasksDeletedScreen extends StatelessWidget {
  const TasksDeletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<TaskModel> listTaskdeleted = context.select<TasksProvider, List<TaskModel>>((value) => value.listTaskModel
        .where(
          (element) => element.deleted == true,
        )
        .toList()
      ..sort((a, b) => a.tmpDateTimeTitle.compareTo(b.tmpDateTimeTitle)));
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("La corbeille", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700)),
          const Text("Liste des tâches supprimées ...", style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic)),
          if (listTaskdeleted.isEmpty) ...[
            const EmptyDataMessageWidget()
          ] else ...[
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 15.0),
              itemCount: listTaskdeleted.length,
              itemBuilder: (context, index) => TaskDeletedCardWidget(task: listTaskdeleted[index]),
            ),
          ],
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_task_diary/models/task_model.dart';
import 'package:my_task_diary/providers/tasks_provider.dart';
import 'package:my_task_diary/views/widgets/cards/task_favorite_card_widget.dart';
import 'package:my_task_diary/views/widgets/messages/empty_data_message_widget.dart';
import 'package:provider/provider.dart';

class TasksFavoriteScreen extends StatelessWidget {
  const TasksFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<TaskModel> listTaskFavorite = context.select<TasksProvider, List<TaskModel>>((value) => value.listTaskModel
        .where(
          (element) => element.favorite == true && element.deleted == false,
        )
        .toList()
      ..sort((a, b) => a.tmpDateTimeTitle.compareTo(b.tmpDateTimeTitle)));
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Vos favoris", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700)),
          const Text("Liste des tâches préférées ...", style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic)),
          if (listTaskFavorite.isEmpty) ...[
            const EmptyDataMessageWidget()
          ] else ...[
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 15.0),
              itemCount: listTaskFavorite.length,
              itemBuilder: (context, index) => TaskFavoriteCardWidget(task: listTaskFavorite[index]),
            ),
          ],
        ],
      ),
    );
  }
}

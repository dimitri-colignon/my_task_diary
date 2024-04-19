import 'package:flutter/material.dart';
import 'package:my_task_diary/libraries/dates_library.dart';
import 'package:my_task_diary/models/task_model.dart';
import 'package:my_task_diary/providers/interface_provider.dart';
import 'package:my_task_diary/providers/tasks_provider.dart';
import 'package:my_task_diary/views/widgets/cards/task_actived_card_widget.dart';
import 'package:my_task_diary/views/widgets/messages/empty_data_message_widget.dart';
import 'package:my_task_diary/views/widgets/selections/date_picker_selection_widget.dart';
import 'package:provider/provider.dart';

class TasksActivedcreen extends StatelessWidget {
  final bool isActived;

  const TasksActivedcreen({
    super.key,
    required this.isActived,
  });

  @override
  Widget build(BuildContext context) {
    int dateTask = DatesLibrary.getEpochFromDateTime(date: context.watch<InterfaceProvider>().datePickerSelectedDate);
    List<TaskModel> listTaskActived = context.select<TasksProvider, List<TaskModel>>((value) => value.listTaskModel
        .where(
          (element) => element.actived == isActived && element.dateTask == dateTask && element.deleted == false,
        )
        .toList()
      ..sort((a, b) => a.tmpDateTitle.compareTo(b.tmpDateTitle)));
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text((isActived) ? "Tâches ouvertes" : "Tâches fermées", style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700)),
          const Text("Choisissez une date ...", style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic)),
          const DatePickerSelectionWidget(),
          const SizedBox(height: 5.0),
          const Text("Liste des tâches du jour ...", style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic)),
          if (listTaskActived.isEmpty) ...[
            const EmptyDataMessageWidget()
          ] else ...[
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 15.0),
              itemCount: listTaskActived.length,
              itemBuilder: (context, index) => TaskActivedCardWidget(task: listTaskActived[index]),
            ),
          ],
        ],
      ),
    );
  }
}

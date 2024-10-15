import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_task_diary/libraries/dates_library.dart';
import 'package:my_task_diary/libraries/enum_library.dart';
import 'package:my_task_diary/libraries/messages_library.dart';
import 'package:my_task_diary/libraries/themes_library.dart';
import 'package:my_task_diary/models/task_model.dart';
import 'package:my_task_diary/providers/tasks_provider.dart';
import 'package:my_task_diary/views/widgets/inputs/date_input_widget.dart';
import 'package:my_task_diary/views/widgets/inputs/description_input_widget.dart';
import 'package:my_task_diary/views/widgets/inputs/time_input_widget.dart';
import 'package:my_task_diary/views/widgets/inputs/title_input_widget.dart';
import 'package:my_task_diary/views/widgets/selections/priority_dropdown_selection_widget.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class TasksFormWidget extends StatefulWidget {
  final TaskModel? task;

  const TasksFormWidget({
    super.key,
    this.task,
  });

  @override
  State<TasksFormWidget> createState() => _TasksFormWidgetState();
}

class _TasksFormWidgetState extends State<TasksFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleTaskController = TextEditingController(text: "");
  final TextEditingController _descriptionTaskController = TextEditingController(text: "");
  final TextEditingController _dateTaskController = TextEditingController(text: "");
  final TextEditingController _timeTaskController = TextEditingController(text: "");

  bool _actived = false;
  bool _favorite = false;
  String? _title;
  String? _description;
  int? _dateEpoch;
  int? _timeEpoch;
  int _priority = 0;

  bool _insertState = true;

  DateTime _currentDate = DateTime.now();
  TimeOfDay _currentTime = TimeOfDay.now();

  @override
  void initState() {
    if (widget.task != null) {
      _insertState = false;
      _actived = widget.task!.actived;
      _favorite = widget.task!.favorite;
      _title = widget.task!.title;
      _description = widget.task!.description;
      _dateEpoch = widget.task!.dateTask;
      _timeEpoch = widget.task!.timeTask;
      _priority = widget.task!.priority;
      _titleTaskController.text = widget.task!.title;
      _descriptionTaskController.text = widget.task!.description;
      _currentDate = DateTime.fromMillisecondsSinceEpoch(widget.task!.dateTask);
      _currentTime = TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(widget.task!.timeTask));
      _dateTaskController.text = DatesLibrary.getDateStringFromDateTime(date: _currentDate);
      _timeTaskController.text = DatesLibrary.getTimeStringFromEpoch(epoch: widget.task!.timeTask);
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleTaskController.dispose();
    _descriptionTaskController.dispose();
    _dateTaskController.dispose();
    _timeTaskController.dispose();
    super.dispose();
  }

  void _saveData({required BuildContext context}) async {
    if (_formKey.currentState!.validate()) {
      try {
        EasyLoading.show(status: "Sauvegarde ...");
        _formKey.currentState!.save();
        if (_insertState) {
          if (await context.read<TasksProvider>().insertTask(
                    map: TaskModel(
                      idTask: const Uuid().v4(),
                      deleted: false,
                      actived: _actived,
                      favorite: _favorite,
                      title: _title!,
                      description: _description!,
                      dateTask: _dateEpoch!,
                      timeTask: _timeEpoch!,
                      priority: _priority,
                    ),
                  ) ==
              false) {
            throw "Erreur lors de l'ajout de la tâche!";
          }
          if (!context.mounted) return;
          EasyLoading.dismiss();
          MessagesLibrary.showSnackBar(context: context, message: "La tâche est ajoutée!");
        } else {
          if (await context.read<TasksProvider>().updateTask(
                    oldMap: widget.task!,
                    newMap: TaskModel(
                      idTask: widget.task!.idTask,
                      deleted: false,
                      actived: _actived,
                      favorite: _favorite,
                      title: _title!,
                      description: _description!,
                      dateTask: _dateEpoch!,
                      timeTask: _timeEpoch!,
                      priority: _priority,
                    ),
                  ) ==
              false) {
            throw "Erreur lors de la modification de la tâche!";
          }
          if (!context.mounted) return;
          EasyLoading.dismiss();
          MessagesLibrary.showSnackBar(context: context, message: "La tâche est modifiée!");
        }
        Navigator.pop(context);
      } catch (e) {
        EasyLoading.dismiss();
        MessagesLibrary.showSnackBar(context: context, message: e.toString(), typeMessage: TypeMessage.typeError);
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          Center(
            child: Text((_insertState) ? "Ajouter une tâche!" : "Modifier la tâche!", style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 10.0),
          TitleInputWidget(
            titleController: _titleTaskController,
            onSave: (title) => _title = title,
          ),
          DescriptionInputWidget(
            descriptionController: _descriptionTaskController,
            onSave: (description) => _description = description,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DateInputWidget(
                  dateController: _dateTaskController,
                  currentDate: _currentDate,
                  onSave: (epoch) => _dateEpoch = epoch,
                ),
              ),
              Expanded(
                child: TimeInputWidget(
                  timeController: _timeTaskController,
                  currentTime: _currentTime,
                  onSave: (epoch) => _timeEpoch = epoch,
                ),
              ),
            ],
          ),
          PriorityDropdownSelectionWidget(
            currentPriority: _priority,
            onSave: (priority) => _priority = priority,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Préférée:", style: ThemesLibrary.kTextStyleInputDecoration),
                      Switch(
                        thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return const Icon(FontAwesomeIcons.solidHeart, color: ThemesLibrary.kColorDefaultRed);
                            }
                            return null;
                          },
                        ),
                        trackColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return ThemesLibrary.kColorDefaultRed;
                            }
                            return ThemesLibrary.kColorDefaultOnPrimary;
                          },
                        ),
                        value: _favorite,
                        onChanged: (value) => setState(() => _favorite = value),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Status:", style: ThemesLibrary.kTextStyleInputDecoration),
                      Switch(
                        thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return const Icon(FontAwesomeIcons.unlock, color: ThemesLibrary.kColorDefaultGreen);
                            }
                            return null;
                          },
                        ),
                        trackColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return ThemesLibrary.kColorDefaultGreen;
                            }
                            return ThemesLibrary.kColorDefaultOnPrimary;
                          },
                        ),
                        value: _actived,
                        onChanged: (value) => setState(() => _actived = value),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 140.0,
                  child: FilledButton(
                    style: ThemesLibrary.kFilledButton,
                    onPressed: () => _saveData(context: context),
                    child: const Text("SAUVER"),
                  ),
                ),
                const SizedBox(width: 10.0),
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
        ],
      ),
    );
  }
}

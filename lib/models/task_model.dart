import 'package:my_task_diary/databases/helper_database.dart';
import 'package:my_task_diary/libraries/dates_library.dart';

class TaskModel {
  final String idTask;
  bool deleted;
  bool actived;
  bool favorite;
  String title;
  String description;
  int dateTask;
  int timeTask;
  int priority;
  String tmpDateTitle;
  String tmpDateTimeTitle;

  TaskModel({
    required this.idTask,
    required this.deleted,
    required this.actived,
    required this.favorite,
    required this.title,
    required this.description,
    required this.dateTask,
    required this.timeTask,
    required this.priority,
    this.tmpDateTitle = "",
    this.tmpDateTimeTitle = "",
  }) {
    tmpDateTitle = "${DatesLibrary.getTimeStringFromEpoch(epoch: timeTask)} - $title";
    tmpDateTimeTitle = "${DatesLibrary.getFullDateAndTimeStringFromEpoch(dateEpoch: dateTask, timeEpoch: timeTask)} - $title";
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        idTask: json[HelperDatabase.kItemIdTask],
        deleted: (json[HelperDatabase.kItemDeleted] == 0) ? false : true,
        actived: (json[HelperDatabase.kItemActived] == 0) ? false : true,
        favorite: (json[HelperDatabase.kItemFavorite] == 0) ? false : true,
        title: json[HelperDatabase.kItemTitle],
        description: json[HelperDatabase.kItemDescription],
        dateTask: json[HelperDatabase.kItemDateTask],
        timeTask: json[HelperDatabase.kItemTimeTask],
        priority: json[HelperDatabase.kItemPriority],
      );

  Map<String, dynamic> toJson() => {
        HelperDatabase.kItemIdTask: idTask,
        HelperDatabase.kItemDeleted: (deleted == false) ? 0 : 1,
        HelperDatabase.kItemActived: (actived == false) ? 0 : 1,
        HelperDatabase.kItemFavorite: (favorite == false) ? 0 : 1,
        HelperDatabase.kItemTitle: title,
        HelperDatabase.kItemDescription: description,
        HelperDatabase.kItemDateTask: dateTask,
        HelperDatabase.kItemTimeTask: timeTask,
        HelperDatabase.kItemPriority: priority,
      };
}

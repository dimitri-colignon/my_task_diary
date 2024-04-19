import 'package:flutter/material.dart';
import 'package:my_task_diary/databases/helper_database.dart';
import 'package:my_task_diary/libraries/dates_library.dart';
import 'package:my_task_diary/models/task_model.dart';

class TasksProvider with ChangeNotifier {
  TasksProvider() {
    _initData();
  }

  final List<TaskModel> _listTaskModel = [];

  List<TaskModel> get listTaskModel => _listTaskModel;

  void _initData() async {
    _listTaskModel.addAll(await _selectAllTasks());
    notifyListeners();
  }

  Future<List<TaskModel>> _selectAllTasks() async => await HelperDatabase.instance.getAllTasks();

  Future<bool> insertTask({required TaskModel map}) async {
    if (await HelperDatabase.instance.insertTasks(map: map) > 0) {
      _listTaskModel.add(map);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> updateTask({required TaskModel oldMap, required TaskModel newMap}) async {
    if (await HelperDatabase.instance.updateTasks(map: newMap) > 0) {
      final int taskIndex = _listTaskModel.indexOf(oldMap);
      _listTaskModel[taskIndex] = newMap;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> manageOneTrashTask({required TaskModel map}) async {
    final int taskIndex = _listTaskModel.indexOf(map);
    final bool isDeleted = _listTaskModel[taskIndex].deleted;
    _listTaskModel[taskIndex].deleted = !isDeleted;
    if (await HelperDatabase.instance.updateTasks(map: map) > 0) {
      notifyListeners();
      return true;
    } else {
      _listTaskModel[taskIndex].deleted = isDeleted;
      return false;
    }
  }

  Future<bool> manageOneFavorisTask({required TaskModel map}) async {
    final int taskIndex = _listTaskModel.indexOf(map);
    _listTaskModel[taskIndex].favorite = false;
    if (await HelperDatabase.instance.updateTasks(map: map) > 0) {
      notifyListeners();
      return true;
    } else {
      _listTaskModel[taskIndex].favorite = true;
      return false;
    }
  }

  Future<int> deleteAllTasksFromTrash() async {
    int result = await HelperDatabase.instance.deleteAllTasksFromTrash();
    if (result > 0) {
      _listTaskModel.removeWhere((element) => element.deleted == true);
      notifyListeners();
    }
    return result;
  }

  Future<int> restaureAllTasksFromTrash() async {
    final List<TaskModel> queryTask = _listTaskModel.where((element) => element.deleted == true).toList();
    for (var element in queryTask) {
      final int taskIndex = _listTaskModel.indexOf(element);
      _listTaskModel[taskIndex].deleted = false;
      await HelperDatabase.instance.updateTasks(map: _listTaskModel[taskIndex]);
    }
    if (queryTask.isNotEmpty) notifyListeners();
    return queryTask.length;
  }

  Future<int> putAllTaskBeforeNowOnTrash() async {
    final int epoch = DatesLibrary.getEpochFromDateTime(date: DateTime.now());
    final List<TaskModel> queryTask = _listTaskModel.where((element) => element.dateTask < epoch && element.deleted == false).toList();
    for (var element in queryTask) {
      final int taskIndex = _listTaskModel.indexOf(element);
      _listTaskModel[taskIndex].deleted = true;
      await HelperDatabase.instance.updateTasks(map: _listTaskModel[taskIndex]);
    }
    if (queryTask.isNotEmpty) notifyListeners();
    return queryTask.length;
  }

  Future<int> putAllClosedTaskOnTrash() async {
    final List<TaskModel> queryTask = _listTaskModel.where((element) => element.actived == false && element.deleted == false).toList();
    for (var element in queryTask) {
      final int taskIndex = _listTaskModel.indexOf(element);
      _listTaskModel[taskIndex].deleted = true;
      await HelperDatabase.instance.updateTasks(map: _listTaskModel[taskIndex]);
    }
    if (queryTask.isNotEmpty) notifyListeners();
    return queryTask.length;
  }
}

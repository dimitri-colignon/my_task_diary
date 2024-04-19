import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_task_diary/views/screens/tasks_actived_screen.dart';
import 'package:my_task_diary/views/screens/tasks_deleted_screen.dart';
import 'package:my_task_diary/views/screens/tasks_favorite_screen.dart';

class InterfaceBottomNavigationBarModel {
  final String title;
  final IconData icon;
  final Widget child;

  InterfaceBottomNavigationBarModel({
    required this.title,
    required this.icon,
    required this.child,
  });
}

List<InterfaceBottomNavigationBarModel> listInterfaceBottomNavigationBar = [
  InterfaceBottomNavigationBarModel(title: "Tâches ouvertes", icon: FontAwesomeIcons.unlock, child: const TasksActivedcreen(isActived: true)),
  InterfaceBottomNavigationBarModel(title: "Tâches fermées", icon: FontAwesomeIcons.lock, child: const TasksActivedcreen(isActived: false)),
  InterfaceBottomNavigationBarModel(title: "Tâches préférées", icon: FontAwesomeIcons.solidHeart, child: const TasksFavoriteScreen()),
  InterfaceBottomNavigationBarModel(title: "Tâches supprimées", icon: FontAwesomeIcons.solidTrashCan, child: const TasksDeletedScreen()),
];

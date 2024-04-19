import 'package:my_task_diary/models/task_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HelperDatabase {
  // *********************************************************************************************
  // *** Information database.
  // *********************************************************************************************

  // Base de donnée:
  static const String kDbName = "mtk.db";

  // Tables:
  static const String kTableTask = "task";

  // Items:
  static const String kItemIdTask = "idTask";
  static const String kItemDeleted = "isDeleted";
  static const String kItemActived = "isActived";
  static const String kItemFavorite = "isFavorite";
  static const String kItemTitle = "title";
  static const String kItemDescription = "description";
  static const String kItemDateTask = "dateTask";
  static const String kItemTimeTask = "timeTask";
  static const String kItemPriority = "priority";

  // *********************************************************************************************
  // *** Création des la DB et initialisation.
  // *********************************************************************************************

  HelperDatabase._privateConstructor();
  static final HelperDatabase instance = HelperDatabase._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    String directory = await getDatabasesPath();
    String path = join(directory, kDbName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    // Table des tâches.
    await db.execute(
      '''CREATE TABLE IF NOT EXISTS "$kTableTask" (
        "$kItemIdTask" TEXT NOT NULL,
        "$kItemDeleted" INTEGER,
        "$kItemActived" INTEGER,
        "$kItemFavorite" INTEGER,
        "$kItemTitle"	TEXT NOT NULL,
        "$kItemDescription" TEXT,
        "$kItemDateTask" INTEGER,
        "$kItemTimeTask" INTEGER,
        "$kItemPriority" INTEGER,
        PRIMARY KEY("$kItemIdTask"))''',
    );
  }

  // *********************************************************************************************
  // *** Fermeture database.
  // *********************************************************************************************
  Future close() async {
    Database? db = await instance.database;
    db!.close();
  }

  // *********************************************************************************************
  // *** Table task
  // *********************************************************************************************

  // ***
  // *** Select all de la table task a une date donnée.
  // ***
  Future<List<TaskModel>> getAllTasks() async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> response = await db!.query(
      kTableTask,
      orderBy: "$kItemTimeTask, $kItemTitle",
    );
    return response.map((c) => TaskModel.fromJson(c)).toList();
  }

  // ***
  // *** Insert dans la table task.
  // ***
  Future<int> insertTasks({required TaskModel map}) async {
    Database? db = await instance.database;
    return await db!.insert(
      kTableTask,
      map.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ***
  // *** Update dans la table task.
  // ***
  Future<int> updateTasks({required TaskModel map}) async {
    Database? db = await instance.database;
    return await db!.update(
      kTableTask,
      map.toJson(),
      where: "$kItemIdTask = ?",
      whereArgs: [map.idTask],
    );
  }

  // ***
  // *** Delete dans la table task les items dans la poubelle.
  // ***
  Future<int> deleteAllTasksFromTrash() async {
    Database? db = await instance.database;
    return db!.delete(
      kTableTask,
      where: "$kItemDeleted = ?",
      whereArgs: [1],
    );
  }
}

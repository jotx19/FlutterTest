import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
import 'ToDoDAO.dart';
import 'ToDoItem.dart';

part 'ToDoDatabase.g.dart'; // the generated code will be there

@Database(version: 2, entities: [ToDoItem])
abstract class ToDoDatabase extends FloorDatabase {
  ToDoDao get toDoDao;
}
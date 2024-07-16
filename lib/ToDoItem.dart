import 'package:floor/floor.dart';

@entity
class ToDoItem {
  @primaryKey
  final int? id;
  final String message;

  ToDoItem(this.id, this.message);
}
import 'package:floor/floor.dart';
import 'ToDoDAO.dart';
import 'ToDoItem.dart';

@dao
abstract class ToDoDao {
  @insert
  Future<void> insertItem(ToDoItem item);

  @delete
  Future<int> deleteItem(ToDoItem item);

  @Query('SELECT * FROM ToDoItem WHERE id = :id')
  Future<ToDoItem?> getItemWithId(int id);

  @Query('SELECT * FROM ToDoItem')
  Future<List<ToDoItem>> getAllItems();

  @update
  Future<int> updateItem(ToDoItem item);
}
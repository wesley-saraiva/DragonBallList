import 'package:todo_list_provider/app/models/task_model.dart';

abstract class TaskRepository {
  Future<void> save(DateTime dateTime, String description);
  Future<List<TaskModel>> findByperiod(DateTime start, DateTime end);
  Future<void> checkOrUncheckTask(TaskModel task);
  Future<void> deleteTaskById({required int id});
  Future<void> clearTableTodo();
}

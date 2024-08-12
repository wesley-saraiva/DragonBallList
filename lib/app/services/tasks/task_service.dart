import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/models/week_task_model.dart';

abstract class TaskService {
  Future<void> save(DateTime dateTime, String description);
  Future<List<TaskModel>> getToday();
  Future<List<TaskModel>> getTomorrow();
  Future<WeekTaskModel> getWeek();
  Future<void> clearTableTodo();
  Future<void> checkOrUncheckTask(TaskModel task);
  Future<void> deleteTaskById({required int id});
}

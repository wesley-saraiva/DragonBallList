import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/models/week_task_model.dart';
import 'package:todo_list_provider/app/repositories/task/task_repository.dart';

import './task_service.dart';

class TaskServiceImpl extends TaskService {
  final TaskRepository _taskRepository;

  TaskServiceImpl({required TaskRepository taskRepository})
      : _taskRepository = taskRepository;
  @override
  Future<void> save(DateTime dateTime, String description) =>
      _taskRepository.save(dateTime, description);

  @override
  Future<List<TaskModel>> getToday() {
    return _taskRepository.findByperiod(DateTime.now(), DateTime.now());
  }

  @override
  Future<List<TaskModel>> getTomorrow() {
    var tomorrowDate = DateTime.now().add(Duration(days: 1));
    return _taskRepository.findByperiod(tomorrowDate, tomorrowDate);
  }

  @override
  Future<WeekTaskModel> getWeek() async {
    final today = DateTime.now();
    var startfilter = DateTime(today.year, today.month, today.day, 0, 0, 0);
    DateTime endFilter;

    if (startfilter.weekday != DateTime.monday) {
      startfilter =
          startfilter.subtract(Duration(days: (startfilter.weekday - 1)));
    }
    endFilter = startfilter.add(Duration(days: 7));
    final task = await _taskRepository.findByperiod(startfilter, endFilter);
    return WeekTaskModel(
      startDate: startfilter,
      endDate: endFilter,
      tasks: task,
    );
  }

  @override
  Future<void> checkOrUncheckTask(TaskModel task) =>
      _taskRepository.checkOrUncheckTask(task);

  @override
  Future<void> deleteTaskById({required int id}) =>
      _taskRepository.deleteTaskById(id: id);

  @override
  Future<void> clearTableTodo() => _taskRepository.clearTableTodo();
}

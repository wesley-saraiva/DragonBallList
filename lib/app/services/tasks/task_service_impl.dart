import 'package:todo_list_provider/app/repositories/task/task_repository.dart';

import './task_service.dart';

class TaskServiceImpl extends TaskService {
  final TaskRepository _taskRepository;

  TaskServiceImpl({required TaskRepository taskRepository})
      : _taskRepository = taskRepository;
  @override
  Future<void> save(DateTime dateTime, String description) =>
      _taskRepository.save(dateTime, description);
}

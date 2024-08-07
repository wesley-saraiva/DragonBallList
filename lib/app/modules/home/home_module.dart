import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';

import 'package:todo_list_provider/app/modules/home/home_page.dart';

import '../../repositories/task/task_repository.dart';
import '../../repositories/task/task_repository_impl.dart';
import '../../services/tasks/task_service.dart';
import '../../services/tasks/task_service_impl.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(bindings: [
          Provider<TaskRepository>(
            create: (context) => TaskRepositoryImpl(
              sqliteConnectionFactory: context.read(),
            ),
          ),
          Provider<TaskService>(
            create: (context) => TaskServiceImpl(
              taskRepository: context.read(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => HomeController(taskService: context.read()),
          )
        ], routes: {
          '/home': (context) => HomePage(
                homeController: context.read(),
              ),
        });
}

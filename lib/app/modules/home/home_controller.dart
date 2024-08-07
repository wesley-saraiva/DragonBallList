import 'package:todo_list_provider/app/core/notifier/default_change_notifer.dart';
import 'package:todo_list_provider/app/models/month_task_model.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/models/total_task_model.dart';
import 'package:todo_list_provider/app/models/week_task_model.dart';
import 'package:todo_list_provider/app/services/tasks/task_service.dart';

class HomeController extends DefaultChangeNotifer {
  final TaskService _taskService;
  var filterSelected = TaskFilterEnum.today;
  TotalTaskModel? todayTotalTasks;
  TotalTaskModel? tomorrowTotalTasks;
  TotalTaskModel? weekTotalTasks;
  TotalTaskModel? monthTotalTasks;
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];
  DateTime? initialDateOfWeek;
  DateTime? selectedDay;
  bool showFinishTasks = false;

  HomeController({required TaskService taskService})
      : _taskService = taskService;

  Future<void> loadTotalTask() async {
    final allTasks = await Future.wait([
      _taskService.getToday(),
      _taskService.getTomorrow(),
      _taskService.getWeek(),
      _taskService.getMonth(),
    ]);
    final todayTasks = allTasks[0] as List<TaskModel>;
    final tomorrowTasks = allTasks[1] as List<TaskModel>;
    final weekTasks = allTasks[2] as WeekTaskModel;
    final monthTasks = allTasks[3] as MonthTaskModel;

    todayTotalTasks = TotalTaskModel(
      totalTasks: todayTasks.length,
      totalTasksFinish: todayTasks.where((task) => task.finished).length,
    );
    tomorrowTotalTasks = TotalTaskModel(
      totalTasks: tomorrowTasks.length,
      totalTasksFinish: tomorrowTasks.where((task) => task.finished).length,
    );
    weekTotalTasks = TotalTaskModel(
      totalTasks: weekTasks.tasks.length,
      totalTasksFinish: weekTasks.tasks.where((task) => task.finished).length,
    );
    monthTotalTasks = TotalTaskModel(
      totalTasks: monthTasks.tasks.length,
      totalTasksFinish: monthTasks.tasks.where((task) => task.finished).length,
    );
    notifyListeners();
  }

  Future<void> findTask({required TaskFilterEnum filter}) async {
    filterSelected = filter;
    showLoading();
    notifyListeners();
    List<TaskModel> tasks;

    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _taskService.getToday();
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _taskService.getTomorrow();
        break;

      case TaskFilterEnum.week:
        final weekModel = await _taskService.getWeek();
        initialDateOfWeek = weekModel.startDate;
        tasks = weekModel.tasks;
        break;

      case TaskFilterEnum.month:
        final monthModel = await _taskService.getMonth();
        tasks = monthModel.tasks;
        break;
    }
    filteredTasks = tasks;
    allTasks = tasks;

    if (filter == TaskFilterEnum.week) {
      if (selectedDay != null) {
        filterByDay(selectedDay!);
      }
      if (initialDateOfWeek != null) {
        filterByDay(initialDateOfWeek!);
      }
    } else {
      selectedDay = null;
    }

    if (!showFinishTasks) {
      filteredTasks = filteredTasks.where((task) => !task.finished).toList();
    }

    hideLoading();
    notifyListeners();
  }

  void filterByDay(DateTime date) {
    selectedDay = date;
    filteredTasks = allTasks.where((t) {
      return t.dateTime == date;
    }).toList();
    notifyListeners();
  }

  Future<void> refreshPage() async {
    await findTask(filter: filterSelected);
    await loadTotalTask();
    notifyListeners();
  }

  Future<void> checkOrUnChechTask(TaskModel task) async {
    showLoadingAndResetState();
    notifyListeners();

    final taskUpdate = task.copyWith(finished: !task.finished);
    await _taskService.checkOrUncheckTask(taskUpdate);
    hideLoading();
    refreshPage();
  }

  void showOrHideFinishTask() {
    showFinishTasks = !showFinishTasks;
    refreshPage();
  }
}

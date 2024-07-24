import 'package:todo_list_provider/app/core/notifier/default_change_notifer.dart';
import 'package:todo_list_provider/app/services/tasks/task_service.dart';

class TaskCreateController extends DefaultChangeNotifer {
  final TaskService _taskService;
  DateTime? _selectedDate;

  TaskCreateController({required TaskService taskService})
      : _taskService = taskService;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  Future<void> save(String description) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      if (_selectedDate != null) {
        await _taskService.save(_selectedDate!, description);
        success();
      } else {
        setError('Data da task não selecionada');
      }
    } on Exception catch (e, s) {
      print(e);
      print(s);
      setError('Erro ao cadastrar task');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}

import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';

import './task_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  TaskRepositoryImpl({required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> save(DateTime dateTime, String description) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert(
      'todo',
      {
        'id': null,
        'descricao': description,
        'data_hora': dateTime.toIso8601String(),
        'finalizado': 0,
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';

class SqliteAdmConnection with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final connection = SqliteConnectionFactory();
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        connection.closeConnection();
        break;
    }
    super.didChangeAppLifecycleState(state);
  }
}

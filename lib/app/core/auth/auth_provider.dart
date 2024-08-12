// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';
import 'package:todo_list_provider/app/core/navigator/todo_list_navigator.dart';
import 'package:todo_list_provider/app/core/ui/loader.dart';

import 'package:todo_list_provider/app/services/user/user_service.dart';

class AuthProvide extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final UserService _userService;
  final SqliteConnectionFactory _sqliteConnectionFactory;

  AuthProvide({
    required FirebaseAuth auth,
    required UserService service,
    required SqliteConnectionFactory connection,
  })  : _firebaseAuth = auth,
        _userService = service,
        _sqliteConnectionFactory = connection;

  Future<void> logout() => _userService.logout();

  User? get user => _firebaseAuth.currentUser;

  void loadListener() {
    _firebaseAuth.userChanges().listen((_) => notifyListeners());
    _firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        TodoListNavigator.to.pushNamedAndRemoveUntil('/home', (route) => false);
      } else {
        TodoListNavigator.to
            .pushNamedAndRemoveUntil('/login', (route) => false);
      }
    });
  }
}

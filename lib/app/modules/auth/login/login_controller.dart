import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifer.dart';
import 'package:todo_list_provider/app/core/ui/message.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';
import 'package:todo_list_provider/app/repositories/user/user_repository_impl.dart';

class LoginController extends DefaultChangeNotifer {
  final UserService _userService;
  String? infoMesage;

  LoginController({required UserService userService})
      : _userService = userService;

  bool get hasInfo => infoMesage != null;

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      infoMesage = null;
      notifyListeners();
      final user = await _userService.login(email, password);
      if (user != null) {
        success();
      } else {
        setError('Usuario ou senha incorretos');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      showLoadingAndResetState();
      infoMesage = null;
      notifyListeners();
      await _userService.forgotPassword(email);
      infoMesage = 'reset de senha enviado para seu e-mail';
    } on AuthException catch (e) {
      setError(e.message);
    } catch (e) {
      setError('Erro ao resetar senha');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable, deprecated_member_use
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _auth;
  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _auth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'email-already-in-use') {
        final logintypes = await _auth.fetchSignInMethodsForEmail(email);
        if (logintypes.contains('passoword')) {
          throw AuthException(
              message: 'E-mail já utilizado por fabvor escolha outro e-mail');
        } else {
          throw AuthException(
              message:
                  'Você se cadastrou TodoListDBZ pelo Google, porfavor utilize ele para entrar');
        }
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuario');
      }
    }
  }
}

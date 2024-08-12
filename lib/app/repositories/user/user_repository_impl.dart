// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable, deprecated_member_use, avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
        final loginTypes = await _auth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(
              message: 'E-mail já utilizado por favor escolha outro e-mail');
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

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: e.message ?? 'Erro ao fazer login');
    } on FirebaseException catch (e, s) {
      print(e);

      print(s);
      throw AuthException(message: e.message ?? 'Erro ao fazer login');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final loginMethods = await _auth.fetchSignInMethodsForEmail(email);

      if (loginMethods.contains('password')) {
        await _auth.sendPasswordResetEmail(email: email);
      } else if (loginMethods.contains('google')) {
        throw AuthException(
            message:
                'Cadastro realizado com o google, nao pode ser resetado a senha');
      } else {
        throw AuthException(message: 'E-mail não cadastrado');
      }
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: 'Erro ao resetar senha');
    }
  }

  @override
  Future<User?> googleLogin() async {
    List<String>? loginMethods;
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        loginMethods = await _auth.fetchSignInMethodsForEmail(googleUser.email);

        if (loginMethods.contains('password')) {
          throw AuthException(
              message:
                  'Você utilizou o e-mail para cadastro no Todo List DBZ, caso tenha esquecido sua senha por favor vai para esqueceu sua senha');
        } else {
          final googleAuth = await googleUser.authentication;
          final firebaseCredential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          var userCredential =
              await _auth.signInWithCredential(firebaseCredential);
          return userCredential.user;
        }
      }
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'account-exists-with-different-credential') {
        throw AuthException(
            message:
                '''Login inválido você se registrou no TodoList DBZ com os seguintes provedores:
                ${loginMethods?.join(',')}
                ''');
      } else {
        throw AuthException(message: 'Erro ao realizar login');
      }
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    _auth.signOut();
  }

  @override
  Future<void> updateDisplayName(String name) async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
      user.reload();
    }
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TodoListLogo(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class TodoListLogo extends StatelessWidget {
  const TodoListLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'Assets/00 - assets/shenlong-removebg.png',
          height: 200,
        ),
        Text(
          'Todo List DBZ',
          style: context.textTheme.titleLarge,
        ),
      ],
    );
  }
}

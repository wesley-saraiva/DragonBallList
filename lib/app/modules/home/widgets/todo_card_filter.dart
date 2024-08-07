// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/total_task_model.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';

class TodoCardFilter extends StatelessWidget {
  final String label;
  final TaskFilterEnum taskFilterEnum;
  final TotalTaskModel? totalTaskModel;
  final bool selected;

  const TodoCardFilter(
      {super.key,
      required this.label,
      required this.taskFilterEnum,
      this.totalTaskModel,
      required this.selected});

  double _getpercentFinish() {
    final total = totalTaskModel?.totalTasks ?? 0.0;
    final totalFinish = totalTaskModel?.totalTasksFinish ?? 0.1;

    if (total == 0) {
      return 0.0;
    }

    final percent = (totalFinish * 100) / total;
    return percent / 100;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<HomeController>().findTask(filter: taskFilterEnum);
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        constraints: BoxConstraints(minHeight: 120, maxWidth: 150),
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: selected ? context.primaryColor : Colors.white,
          border: Border.all(
            width: 1,
            color: Colors.grey.withOpacity(.8),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${totalTaskModel?.totalTasks ?? 0}TASKS',
              style: context.titleStyle.copyWith(
                fontSize: 10,
                color: selected ? Colors.yellow : context.primaryColor,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.yellow : context.primaryColor),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(
                begin: 0.0,
                end: _getpercentFinish(),
              ),
              duration: Duration(seconds: 1),
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  backgroundColor: selected
                      ? context.primaryColorLight
                      : Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                  value: value,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

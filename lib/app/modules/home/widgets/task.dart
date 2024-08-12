import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';

class Task extends StatelessWidget {
  final TaskModel model;
  final dateFormat = DateFormat('dd/MM/y');
  Task({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final TaskModel(:dateTime, :description, :finished) = model;
    final controller = context.read<HomeController>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
        child: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                onPressed: (_) => controller.deleteTask(task: model),
                icon: Icons.delete,
                spacing: 0,
                label: 'Deletar',
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(8),
            leading: Checkbox(
              value: model.finished,
              onChanged: (value) =>
                  context.read<HomeController>().checkOrUnChechTask(model),
            ),
            title: Text(
              model.description,
              style: TextStyle(
                decoration: model.finished ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(
              dateFormat.format(model.dateTime),
              style: TextStyle(
                decoration: model.finished ? TextDecoration.lineThrough : null,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(width: 1),
            ),
          ),
        ),
      ),
    );
  }
}

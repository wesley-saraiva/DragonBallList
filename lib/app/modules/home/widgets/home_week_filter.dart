// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.select<HomeController, bool>(
        (controller) => controller.filterSelected == TaskFilterEnum.week,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            'DIA DA SEMANA',
            style: context.titleStyle,
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 95,
            child: Selector<HomeController, DateTime>(
              selector: (context, controller) =>
                  controller.initialDateOfWeek ?? DateTime.now(),
              builder: (_, value, __) {
                return DatePicker(
                  value,
                  locale: 'pt_BR',
                  initialSelectedDate: value,
                  selectionColor: context.primaryColor,
                  selectedTextColor: Color.fromARGB(255, 142, 216, 144),
                  monthTextStyle: TextStyle(fontSize: 8),
                  dateTextStyle: TextStyle(fontSize: 13),
                  dayTextStyle: TextStyle(fontSize: 13),
                  onDateChange: (date) =>
                      context.read<HomeController>().filterByDay(date),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

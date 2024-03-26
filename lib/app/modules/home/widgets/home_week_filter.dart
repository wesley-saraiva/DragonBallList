// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: DatePicker(
            DateTime.now(),
            locale: 'pt_BR',
            initialSelectedDate: DateTime.now(),
            selectionColor: context.primaryColor,
            selectedTextColor: Colors.white,
            monthTextStyle: TextStyle(fontSize: 8),
            dateTextStyle: TextStyle(fontSize: 13),
            dayTextStyle: TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}

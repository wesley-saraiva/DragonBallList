// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoListUiConfig {
  TodoListUiConfig._();

  static ThemeData get theme => ThemeData(
        useMaterial3: false,
        textTheme: GoogleFonts.mandaliTextTheme(),
        primaryColor: Colors.lightBlue[300],
        primaryColorLight: Color.fromARGB(255, 135, 136, 129),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue[300],
          ),
        ),
      );
}

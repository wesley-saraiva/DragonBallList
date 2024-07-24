// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoListUiConfig {
  TodoListUiConfig._();

  static ThemeData get theme => ThemeData(
        useMaterial3: false,
        textTheme: GoogleFonts.mandaliTextTheme(),
        primaryColor: const Color.fromARGB(255, 142, 216, 144),
        primaryColorLight: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 248, 229, 57),
              textStyle: TextStyle(color: Colors.green)),
        ),
      );
}

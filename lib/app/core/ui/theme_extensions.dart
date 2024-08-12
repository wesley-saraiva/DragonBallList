import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get primaryColorLight => Theme.of(this).primaryColorLight;
  ButtonThemeData get buttonColor => Theme.of(this).buttonTheme;
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle get titleStyle => TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 129, 219, 132));

  TextStyle get titleStyle2 => TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, color: Colors.yellow);

  TextStyle get titleStyle3 => TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 142, 216, 144));
}

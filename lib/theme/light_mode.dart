import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Colors.white,
    secondary: Colors.blue.shade500,
    inversePrimary: Color.fromARGB(255, 2, 14, 33),
  ),
  textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'Poppins',
        bodyColor: Colors.grey[900],
        displayColor: Colors.black,
      ),
);

import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
      primary: Colors.black,
      secondary: Colors.grey.shade900,
      inversePrimary: Colors.grey.shade300),
  textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: 'Poppins',
        bodyColor: Color.fromARGB(255, 254, 243, 243),
        displayColor: Colors.white,
      ),
);

import 'package:flutter/material.dart';

class ElevatedButton1 {
  ElevatedButton1._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          foregroundColor: Colors.white,
          backgroundColor: Colors.black87,
          side: const BorderSide(color: Colors.black),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)));

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          side: BorderSide(color: Colors.black),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)));
}

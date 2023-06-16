import 'package:flutter/material.dart';

class OutlinedButton1 {
  OutlinedButton1._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.black),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)));

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)));
}

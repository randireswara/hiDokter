import 'package:flutter/material.dart';

class TextFormFieldd {
  TextFormFieldd._();

  static InputDecorationTheme lightInput = const InputDecorationTheme(
      prefixIconColor: Colors.black,
      border: OutlineInputBorder(),
      floatingLabelStyle: TextStyle(color: Colors.black),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.black)));

  static InputDecorationTheme darkInput = const InputDecorationTheme(
      prefixIconColor: Colors.white,
      border: OutlineInputBorder(),
      floatingLabelStyle: TextStyle(color: Colors.white),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.white)));
}

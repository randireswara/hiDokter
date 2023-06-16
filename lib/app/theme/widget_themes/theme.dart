import 'package:flutter/material.dart';
import 'package:hi_dokter/app/theme/widget_themes/elevated_button.dart';
import 'package:hi_dokter/app/theme/widget_themes/text_field.dart';
import 'package:hi_dokter/app/theme/widget_themes/text_theme.dart';

import 'outlined_button_themes.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TTextTheme.lightTextTheme,
    outlinedButtonTheme: OutlinedButton1.lightOutlinedButtonTheme,
    elevatedButtonTheme: ElevatedButton1.lightElevatedButtonTheme,
    inputDecorationTheme: TextFormFieldd.lightInput,
  );

  static ThemeData darkTheme = ThemeData(
    outlinedButtonTheme: OutlinedButton1.darkOutlinedButtonTheme,
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: ElevatedButton1.lightElevatedButtonTheme,
    inputDecorationTheme: TextFormFieldd.darkInput,
  );
}

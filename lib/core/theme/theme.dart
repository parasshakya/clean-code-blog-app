import 'package:clean_code_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: 3));

  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      chipTheme: const ChipThemeData(
          color: MaterialStatePropertyAll(AppPallete.backgroundColor)),
      inputDecorationTheme: InputDecorationTheme(
          border: border(),
          contentPadding: const EdgeInsets.all(27),
          focusedBorder: border(AppPallete.gradient2),
          enabledBorder: border(),
          errorBorder: border(AppPallete.errorColor)));
}

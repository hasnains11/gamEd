import 'package:flutter/material.dart';
import 'package:gamed/utils/theme/widget_themes/text_formfield.dart';
import 'package:gamed/utils/theme/widget_themes/text_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blueGrey,
      brightness: Brightness.light,
      textTheme: AppTextTheme.lightColorTheme,
      inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      // backgroundColor: Colors.black,
      brightness: Brightness.dark,
      textTheme: AppTextTheme.darktColorTheme,
      inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nomishop/util/theme/custom_themes/appbar_theme.dart';
import 'package:nomishop/util/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:nomishop/util/theme/custom_themes/checkbox_theme.dart';
import 'package:nomishop/util/theme/custom_themes/chip_theme.dart';
import 'package:nomishop/util/theme/custom_themes/elevated_button.dart';
import 'package:nomishop/util/theme/custom_themes/outline_button_theme.dart';
import 'package:nomishop/util/theme/custom_themes/text_theme.dart';
import 'package:nomishop/util/theme/custom_themes/textfield_theme.dart';

class NAppTheme {
  NAppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: const Color(0xFF386B6F),
    scaffoldBackgroundColor: Colors.white,
    textTheme: NTextTheme.lightTextThem,
    chipTheme: NChipTheme.lightChipTheme,
    appBarTheme: NAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: NBottomSheetTheme.lightBottomSheetThem,
    checkboxTheme: NCheckBoxTheme.lightCheckBoxTheme,
    elevatedButtonTheme: NElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: NTextFieldTheme.lightInputDecorationTheme,
    outlinedButtonTheme: NOutlineButtonTheme.lightOutlineButtonTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF386B6F),
    scaffoldBackgroundColor: Colors.black,
    textTheme: NTextTheme.darkTextTheme,
    appBarTheme: NAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: NBottomSheetTheme.darkBottomSheetThem,
    checkboxTheme: NCheckBoxTheme.darkCheckBoxTheme,
    chipTheme: NChipTheme.darkChipTheme,
    elevatedButtonTheme: NElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: NOutlineButtonTheme.darkOutlineButtonTheme,
    inputDecorationTheme: NTextFieldTheme.darkInputDecorationTheme,
  );
}

import 'package:flutter/material.dart';

class NChipTheme{
  NChipTheme._();
  static ChipThemeData lightChipTheme =ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor:  const Color(0xFFE0EAEB),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: Colors.white,
  );
  static ChipThemeData darkChipTheme =const ChipThemeData(
    disabledColor: Colors.grey,
    labelStyle: TextStyle(color: Colors.black),
    selectedColor:  Color(0xFFE0EAEB),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: Colors.white,
  );
}
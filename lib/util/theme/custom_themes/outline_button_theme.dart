import 'package:flutter/material.dart';

class NOutlineButtonTheme{
  NOutlineButtonTheme._();
  static final lightOutlineButtonTheme= OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      side: const BorderSide(color: Color(0xFF386B6F)),
      textStyle: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
    )
  );
  static final darkOutlineButtonTheme= OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          side: const BorderSide(color:  Color(0xFF386B6F)),
          textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
      )

  );
}
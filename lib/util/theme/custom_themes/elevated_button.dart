import 'package:flutter/material.dart';

class NElevatedButtonTheme{
  NElevatedButtonTheme._();
  static final lightElevatedButtonTheme= ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor:  const Color(0xFF386B6F),
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey,
      padding: const EdgeInsets.symmetric(vertical:  18),
      side: const BorderSide(color:  Color(0xFFE0EAEB),),
        textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),


  );
  static final darkElevatedButtonTheme= ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
  elevation: 0,
  foregroundColor: Colors.white,
  backgroundColor:  const Color(0xFF386B6F),
  disabledBackgroundColor: Colors.grey,
  disabledForegroundColor: Colors.grey,
  padding: const EdgeInsets.symmetric(vertical:  18),
  side: const BorderSide(color:  Color(0xFF386B6F),),
  textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ));

}
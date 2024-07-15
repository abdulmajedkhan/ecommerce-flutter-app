import 'package:flutter/material.dart';
import 'package:nomishop/util/constants/colors.dart';
class NShadowStyle{
  static final verticalProductShadow=BoxShadow(
    color: NColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset:  const Offset(0,2),

  );
  static final horizontalProductShadow=BoxShadow(
    color: Colors.grey.shade600.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset:  const Offset(0,2),
  );
}
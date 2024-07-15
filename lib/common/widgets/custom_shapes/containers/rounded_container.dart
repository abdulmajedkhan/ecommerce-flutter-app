import 'package:flutter/material.dart';
import 'package:nomishop/util/constants/colors.dart';
import 'package:nomishop/util/constants/sizes.dart';

class NRoundedContainer extends StatelessWidget {
  const NRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = NSizes.cardRadiusLg,
    this.child,
this.borderColor=NColors.borderPrimary,
    this.backgroundColor = Colors.white,
    this.padding,
    this.margin,
    this.showBorder=false
  });
  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: showBorder
            ? [
          BoxShadow(
            color: borderColor,
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ]
            : null,
      ),
      child: child,
    );
  }
}

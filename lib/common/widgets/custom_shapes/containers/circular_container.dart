import 'package:flutter/material.dart';
import 'package:nomishop/util/constants/colors.dart';

class NCircularContainer extends StatelessWidget {
  const NCircularContainer(
      {super.key,
      this.width,
      this.height,
      this.radius,
      this.padding=0,
      this.child,
     this.backgroundColor=NColors.white});

  final double? width;
  final double? height;
  final double? radius;
  final double padding;
  final Widget? child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius!),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}

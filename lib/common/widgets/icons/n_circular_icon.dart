import 'package:flutter/material.dart';
import 'package:nomishop/util/constants/colors.dart';
import 'package:nomishop/util/constants/sizes.dart';
import 'package:nomishop/util/helpers/helper_functions.dart';

class NCircularIcon extends StatelessWidget {
  const NCircularIcon({
    Key? key,
    this.width,
    this.height,
    this.size = NSizes.lg,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
  }) : super(key: key);

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = NHelperFunctions.isDarkMode(context);

    return Container(
      width: width ?? size,
      height: height ?? size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor != null
            ? backgroundColor
            : dark
            ? NColors.black.withOpacity(0.9)
            : NColors.white.withOpacity(0.9),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color ?? (dark ? NColors.white : NColors.black), // Default icon color
          size: size,
        ),
      ),
    );
  }
}

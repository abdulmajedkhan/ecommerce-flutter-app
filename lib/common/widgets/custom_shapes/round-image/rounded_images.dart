import 'package:flutter/material.dart';
import 'package:nomishop/util/constants/colors.dart';
import 'package:nomishop/util/constants/sizes.dart';

class NRoundedImage extends StatelessWidget {
  const NRoundedImage(
      {super.key,
      this.width,
      this.height,
      required this.imageUrl,
      this.applyImageRadius = true,
      this.border,
      this.backgroundColor = NColors.light,
      this.fit,
      this.padding,
      this.onPressed,
      this.borderRadius = NSizes.md,
      this.isNetworkImage = false});
  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius), border: border),
      child: ClipRRect(
        borderRadius: applyImageRadius
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.zero,
        child: Image(
            fit: fit,
            image: isNetworkImage
                ? NetworkImage(imageUrl)
                : AssetImage(imageUrl) as ImageProvider),
      ),
    );
  }
}

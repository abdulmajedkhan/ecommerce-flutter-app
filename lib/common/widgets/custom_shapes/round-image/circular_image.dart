import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nomishop/common/widgets/shimmer/n_shimmer_effect.dart';
import 'package:nomishop/util/constants/sizes.dart';
import 'package:nomishop/util/helpers/helper_functions.dart';


import '../../../../util/constants/colors.dart';

class NCircularImage extends StatelessWidget {
  const NCircularImage(
      {super.key,
      this.fit = BoxFit.cover,
      required this.image,
      this.isNetworkImage = false,
      this.overlayColor,
      this.backgroundColor,
      this.width = 56,
      this.height = 56,
      this.padding = NSizes.sm});

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: backgroundColor ??
              (NHelperFunctions.isDarkMode(context)
                  ? NColors.black
                  : NColors.white),
          borderRadius: BorderRadius.circular(100),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Center(
              child: isNetworkImage
                  ? CachedNetworkImage(
                      imageUrl: image,
                      fit: fit,
                      color: overlayColor,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              const NShimmerEffect(width: 55, height: 55),
                      errorWidget: (context, url, downloadProgress) =>
                          const Icon(Icons.error),
                    )
                  : Image(
                      image: AssetImage(image),
                      fit: fit,
                      color: overlayColor,
                    )),
        ));
  }
}

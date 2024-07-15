import 'package:flutter/material.dart';
import 'package:nomishop/common/widgets/custom_shapes/round-image/circular_image.dart';
import 'package:nomishop/util/helpers/helper_functions.dart';

import '../../../util/constants/colors.dart';
import '../../../util/constants/sizes.dart';

class NVerticalImageText extends StatelessWidget {
  const NVerticalImageText({
    super.key,
    required this.onPressed,
    required this.title,
    this.image = '',
    this.backgroundColor,
    this.isNetworkImage = true,
     this.textColor=NColors.white,
  });

  final void Function()? onPressed;
  final String image, title;

  final Color? backgroundColor;
  final bool isNetworkImage;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            NCircularImage(
              height: 60,
              width: 60,
              image: image,
              fit: BoxFit.fitWidth,
              padding: NSizes.sm * 1.4,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor,
              overlayColor: NHelperFunctions.isDarkMode(context)
                  ? NColors.light
                  : NColors.dark,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

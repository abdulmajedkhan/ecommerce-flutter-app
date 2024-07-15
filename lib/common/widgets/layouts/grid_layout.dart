import 'package:flutter/material.dart';
import 'package:nomishop/util/constants/sizes.dart';

class NGridLayout extends StatelessWidget {
  const NGridLayout({
    super.key, required this.itemCount, this.mainAxisExtent=288, required this.itemBuilder,
  });
final int itemCount;
final double? mainAxisExtent;
final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: NSizes.gridViewSpacing,
        crossAxisSpacing: NSizes.gridViewSpacing,
        mainAxisExtent: mainAxisExtent,

      ), itemBuilder:itemBuilder,
    );
  }
}
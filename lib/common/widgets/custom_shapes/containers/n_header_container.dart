import 'package:flutter/material.dart';
import 'package:nomishop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:nomishop/common/widgets/custom_shapes/curved_edges/curved_edges.dart';

import 'package:nomishop/util/constants/colors.dart';

class NPrimaryHeaderContainer extends StatelessWidget {
  const NPrimaryHeaderContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NCurvedEdges(
      child: Container(
        color: NColors.primary,
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: NCircularContainer(
                backgroundColor: NColors.white.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: NCircularContainer(
                backgroundColor: NColors.white.withOpacity(0.1),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}

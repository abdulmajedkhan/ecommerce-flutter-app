import 'package:flutter/material.dart';
import 'package:nomishop/common/widgets/custom_shapes/curved_edges/custom_curved_edges.dart';
class NCurvedEdges extends StatelessWidget {
  const NCurvedEdges({super.key, required this.child});
final Widget child;

  @override
  Widget build(BuildContext context) {
    return  ClipPath(


      clipper: NCustomCurvedEdges(),
      child: child,
    );
  }
}

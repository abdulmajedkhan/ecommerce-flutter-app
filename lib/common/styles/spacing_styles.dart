import 'package:flutter/cupertino.dart';

import '../../util/constants/sizes.dart';


class NSpacingStyle{
  static const EdgeInsetsGeometry paddingWithAppBarHeight=EdgeInsets.only(top: NSizes.appBarHeight,
      left: NSizes.defaultSpacing,
      bottom: NSizes.defaultSpacing,
      right: NSizes.defaultSpacing
  );
}
import 'package:flutter/material.dart';
import 'package:nomishop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:nomishop/util/helpers/helper_functions.dart';

import '../../../util/constants/colors.dart';

class NChoiceChip extends StatelessWidget {
  const NChoiceChip(
      {super.key, required this.text, required this.selected, this.onSelected});
  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = NHelperFunctions.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent
      ),
      child: ChoiceChip(
        label: isColor ? const SizedBox() :  Text(text),
        onSelected: onSelected,
        selected: selected,
        labelStyle: TextStyle(color: selected ? NColors.white : null),
        avatar: isColor
            ? NCircularContainer(
                width: 50,
                height: 50,
                radius: 25,
                backgroundColor: NHelperFunctions.getColor(text)!,
              )
            : null,
        labelPadding: isColor ? const EdgeInsets.all(0) : null,
        //make Icon in center
        padding: isColor ? const EdgeInsets.all(0) : null,
        shape: isColor ? const CircleBorder() : null,
        backgroundColor: isColor ? NHelperFunctions.getColor(text)! : null,
      ),
    );
  }
}

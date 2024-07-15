import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NProfileMenu extends StatelessWidget {
  const NProfileMenu({
    super.key,
    required this.title,
    required this.value,
    this.icon= Iconsax.arrow_right_34,
    required this.onPressed,
  });
  final String title, value;
  final IconData icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              )),
          Expanded(
              flex: 5,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              )),
          Expanded(child: Icon(icon)),
        ],
      ),
    );
  }
}

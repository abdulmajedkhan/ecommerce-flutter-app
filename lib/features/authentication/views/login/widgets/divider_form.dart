import 'package:flutter/material.dart';
class NDividerForm extends StatelessWidget {
  const NDividerForm({
    super.key,
    required this.dark, required this.dividerText,
  });

  final bool dark;
  final String dividerText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: Divider(
              thickness: 1,
              color: dark ? Colors.grey.shade600 : Colors.black,
              indent: 60,
              endIndent: 5,
            )),
        Text(
          dividerText,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
            child: Divider(
              thickness: 1,
              color: dark ? Colors.grey.shade600 : Colors.black,
              indent: 5,
              endIndent: 60,
            )),
      ],
    );
  }
}
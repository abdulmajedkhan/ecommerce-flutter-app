import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:nomishop/features/authentication/controllers/signup/signup_controller.dart';

import '../../../../../util/constants/sizes.dart';
import '../../../../../util/constants/text_Strings.dart';

class NTermsAndCondition extends StatelessWidget {
  const NTermsAndCondition({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child: Obx(
                ()=>Checkbox(
                  value: controller.privacyPolicy.value,
                  onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value),
            )),
        const SizedBox(
          width: NSizes.spaceBtwItems,
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: '${NTexts.isAgreeTo} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: NTexts.privacy,
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? Colors.white : Colors.blue,
                  decoration: TextDecoration.underline)),
          TextSpan(text: ' and ', style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: NTexts.termsOfUse,
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? Colors.white : Colors.blue,
                  decoration: TextDecoration.underline)),
        ]))
      ],
    );
  }
}

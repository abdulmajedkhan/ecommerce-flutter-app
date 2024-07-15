import 'package:flutter/material.dart';
import 'package:nomishop/features/authentication/views/sign_up_screen/widget/sign_up_form.dart';

import 'package:nomishop/util/constants/sizes.dart';
import 'package:nomishop/util/constants/text_Strings.dart';
import 'package:nomishop/util/helpers/helper_functions.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = NHelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(NSizes.defaultSpacing),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  NTexts.signUpTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: NSizes.spaceBtwSections,
                ),
                NSignupForm(dark: dark)
              ],
            ),
          ),
        ));
  }
}



import 'package:flutter/material.dart';

import 'package:nomishop/common/styles/spacing_styles.dart';
import 'package:nomishop/features/authentication/views/login/widgets/divider_form.dart';
import 'package:nomishop/features/authentication/views/login/widgets/login_form.dart';
import 'package:nomishop/features/authentication/views/login/widgets/login_header.dart';

import 'package:nomishop/util/constants/text_Strings.dart';
import 'package:nomishop/util/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = NHelperFunctions.isDarkMode(context);
    return Scaffold(
        body: SingleChildScrollView(

          child: Padding(
                padding: NSpacingStyle.paddingWithAppBarHeight,
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const NLoginHeader(),
            const NLoginForm(),
                
            //Divider
            NDividerForm(dark: dark, dividerText: NTexts.orSignInWith,)
          ],
                ),
              ),
        ));
  }
}







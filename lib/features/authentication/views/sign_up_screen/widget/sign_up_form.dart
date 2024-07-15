import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';
import 'package:nomishop/features/authentication/controllers/signup/signup_controller.dart';
import 'package:nomishop/features/authentication/views/sign_up_screen/widget/terms_condition.dart';
import 'package:nomishop/util/validators/validators.dart';

import '../../../../../util/constants/sizes.dart';
import '../../../../../util/constants/text_Strings.dart';

class NSignupForm extends StatelessWidget {
  const NSignupForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
        key: controller.signupFormKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        NValidators.validateEmptyText('First Name', value),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Iconsax.user,
                      ),
                      labelText: NTexts.firstName,
                    ),
                  ),
                ),
                const SizedBox(
                  width: NSizes.spaceBtwItems,
                ),
                Expanded(
                  child: TextFormField(
                    validator: (value) =>
                        NValidators.validateEmptyText('Last Name', value),
                    controller: controller.lastName,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Iconsax.user,
                      ),
                      labelText: NTexts.lastName,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: NSizes.spaceBtwInputFields,
            ),
            TextFormField(
              validator: (value) =>
                  NValidators.validateEmptyText('username', value),
              controller: controller.username,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Iconsax.user_edit,
                ),
                labelText: NTexts.userName,
              ),
            ),
            const SizedBox(
              height: NSizes.spaceBtwInputFields,
            ),
            TextFormField(
              validator: (value) => NValidators.validateEmail(value),
              controller: controller.email,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Iconsax.direct,
                ),
                labelText: NTexts.email,
              ),
            ),
            const SizedBox(
              height: NSizes.spaceBtwInputFields,
            ),
            TextFormField(
              validator: (value) => NValidators.validatePhoneNumber(value),
              controller: controller.phoneNumber,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Iconsax.call,
                ),
                labelText: NTexts.phoneNumber,
              ),
            ),
            const SizedBox(
              height: NSizes.spaceBtwInputFields,
            ),
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => NValidators.validPassword(value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Iconsax.password_check,
                    ),
                    labelText: NTexts.password,
                    suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(
                          controller.hidePassword.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye,
                          color: Colors.black,
                        ))),
              ),
            ),
            const SizedBox(
              height: NSizes.spaceBtwInputFields,
            ),
            NTermsAndCondition(dark: dark),
            const SizedBox(
              height: NSizes.spaceBtwSections,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.signup(),
                    child: const Text(NTexts.createAccount))),
          ],
        ));
  }
}



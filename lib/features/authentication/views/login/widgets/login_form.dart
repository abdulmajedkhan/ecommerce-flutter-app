import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nomishop/features/authentication/controllers/login/login_controller.dart';
import 'package:nomishop/features/authentication/views/sign_up_screen/signup_screen.dart';
import 'package:nomishop/util/constants/sizes.dart';
import 'package:nomishop/util/constants/text_Strings.dart';
import 'package:nomishop/util/validators/validators.dart';

class NLoginForm extends StatelessWidget {
  const NLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return SingleChildScrollView(
      child: Column(

        children: [
          Form(
              key: controller.loginFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.email,
                    validator: (value) => NValidators.validateEmail(value),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Iconsax.direct_right,
                      ),
                      labelText: NTexts.email,
                    ),
                  ),
                  const SizedBox(
                    height: NSizes.spaceBtwInputFields,
                  ),
                  Obx(
                    () => TextFormField(
                      validator: (value) =>
                          NValidators.validateEmptyText('Password', value),
                      controller: controller.password,
                      obscureText: controller.hidePassword.value,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Iconsax.password_check,
                          ),
                          labelText: NTexts.password,
                          suffixIcon: IconButton(
                              onPressed: () => controller.hidePassword.value =
                                  !controller.hidePassword.value,
                              icon: Icon(controller.hidePassword.value
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye))),
                    ),
                  ),
                  const SizedBox(
                    height: NSizes.spaceBtwInputFields / 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                  onChanged: (value) => controller.rememberMe
                                      .value = !controller.rememberMe.value,
                                  value: controller.rememberMe.value),
                            ),
                            const Text(NTexts.rememberPass),
                          ],
                        ),
                      ),
                      TextButton(
                        child: const Text(NTexts.forgotPassText),
                        onPressed: () => {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: NSizes.spaceBtwSections,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => controller.emailAndPasswordSignIn(),
                          child: const Text(NTexts.signIn))),
                  const SizedBox(
                    height: NSizes.spaceBtwItems,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () {
                            Get.to(() => const SignUpScreen());
                          },
                          child: const Text(NTexts.createAccount))),
                  const SizedBox(
                    height: NSizes.spaceBtwSections,
                  )
                ],
              )),
        ],
      ),
    );
  }
}

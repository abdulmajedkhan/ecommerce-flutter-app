import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nomishop/features/personilzation/controllers/user_controller.dart';

import '../../../../../util/constants/sizes.dart';
import '../../../../../util/constants/text_Strings.dart';
import '../../../../../util/validators/validators.dart';
class ReAuthenticateLoginForm extends StatelessWidget {
  const ReAuthenticateLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Re Authenticate form'),
      ),
      body:  Padding(padding: const EdgeInsets.all(NSizes.defaultSpacing),
        child: Column(

          children: [
            Form(
                key: controller.reAuthFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.verifyEmail,
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
                        controller: controller.verifyPassword,
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
                      height: NSizes.spaceBtwSections,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () => controller.reAuthenticateWithEmailAndPasswordUser(),
                            child: const Text('Verify'))),




                  ],
                )),
          ],
        ),
      ) ,
    );




  }
}

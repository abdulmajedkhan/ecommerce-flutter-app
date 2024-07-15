import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nomishop/features/personilzation/controllers/update_name_controller.dart';

import '../../../../../util/constants/colors.dart';
import '../../../../../util/constants/sizes.dart';
import '../../../../../util/constants/text_Strings.dart';
import '../../../../../util/validators/validators.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Name',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(NSizes.defaultSpacing),
        child: Column(
          children: [
            Text(
              'Use a real name for easy verification, This name will appear on several pages',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: NColors.darkGrey),
            ),
            const SizedBox(height: NSizes.spaceBtwSections,),
            Form(
              key: controller.updateUserNameFormKey,
                child: Column(
              children: [
                TextFormField(
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
                const SizedBox(
                  height: NSizes.spaceBtwItems,
                ),
                TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      NValidators.validateEmptyText('Last Name', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Iconsax.user,
                    ),
                    labelText: NTexts.lastName,
                  ),
                ),
                const SizedBox(height: NSizes.spaceBtwSections,),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => controller.updateUserName(),
                        child: const Text('Save'))),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

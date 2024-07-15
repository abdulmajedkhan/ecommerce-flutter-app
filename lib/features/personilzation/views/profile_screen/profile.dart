import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nomishop/common/widgets/custom_shapes/round-image/circular_image.dart';
import 'package:nomishop/common/widgets/section_heading/section_heading.dart';
import 'package:nomishop/features/personilzation/controllers/user_controller.dart';
import 'package:nomishop/features/personilzation/views/profile_screen/widgets/change_name_screen.dart';
import 'package:nomishop/features/personilzation/views/profile_screen/widgets/profile_menu.dart';

import '../../../../util/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(NSizes.defaultSpacing),
          child: Column(
            children: [
              ///Profile picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty
                          ? networkImage
                          : 'assets/images/user-1.png';
                      return NCircularImage(
                        image: image,
                        width: 80,
                        height: 80,
                        isNetworkImage: networkImage.isNotEmpty,
                      );
                    }),
                    TextButton(
                        onPressed: () => controller.uploadUserProfilePicture(),
                        child: const Text('Change Profile Picture'))
                  ],
                ),
              ),

              ///Details
              const SizedBox(
                height: NSizes.spaceBtwItems / 2,
              ),
              const Divider(),
              const SizedBox(
                height: NSizes.spaceBtwItems,
              ),
              const NSectionHeading(
                title: 'Profile Information',
                showActionButton: false,
              ),
              const SizedBox(
                height: NSizes.spaceBtwItems,
              ),

              NProfileMenu(
                title: 'Name',
                onPressed: () => Get.to(const ChangeNameScreen()),
                value: controller.user.value.fullName,
              ),
              const SizedBox(
                height: NSizes.spaceBtwItems / 2,
              ),
              NProfileMenu(
                title: 'username',
                onPressed: () {},
                value: controller.user.value.username,
              ),
              const SizedBox(
                height: NSizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: NSizes.spaceBtwItems,
              ),
              const NSectionHeading(
                  title: 'Personal Imformation', showActionButton: false),
              const SizedBox(
                height: NSizes.spaceBtwItems,
              ),
              NProfileMenu(
                title: 'User ID',
                onPressed: () {},
                value: controller.user.value.id,
                icon: Iconsax.copy,
              ),
              const SizedBox(
                height: NSizes.spaceBtwItems / 2,
              ),
              NProfileMenu(
                title: 'E-mail',
                onPressed: () {},
                value: controller.user.value.email,
              ),
              const SizedBox(
                height: NSizes.spaceBtwItems / 2,
              ),
              NProfileMenu(
                title: 'Phone Number',
                onPressed: () {},
                value: controller.user.value.phoneNumber,
              ),
              const SizedBox(
                height: NSizes.spaceBtwItems / 2,
              ),
              NProfileMenu(
                title: 'Gender',
                onPressed: () {},
                value: 'Male',
              ),
              const SizedBox(
                height: NSizes.spaceBtwItems / 2,
              ),
              NProfileMenu(
                title: 'Date of Birth',
                onPressed: () {},
                value: '10, oct, 1994',
              ),
              const SizedBox(
                height: NSizes.spaceBtwItems,
              ),

              Center(
                child: TextButton(
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () => controller.deleteAccountWarningPopup(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

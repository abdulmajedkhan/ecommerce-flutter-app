import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nomishop/common/widgets/custom_shapes/containers/n_header_container.dart';
import 'package:nomishop/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:nomishop/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:nomishop/common/widgets/section_heading/section_heading.dart';
import 'package:nomishop/features/Shop/screens/order/order.dart';
import 'package:nomishop/features/personilzation/views/address/address.dart';
import 'package:nomishop/features/personilzation/views/profile_screen/widgets/upload_data_screen.dart';
import 'package:nomishop/util/constants/sizes.dart';

import '../../../../../util/constants/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            NPrimaryHeaderContainer(
                child: Container(
              color: NColors.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: NSizes.spaceBtwSections + 10,
                  ),
                  Text(
                    'Account',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: NColors.white),
                  ),

                  ///User Profile card
                  const NUserProfileTile(),
                  const SizedBox(
                    height: NSizes.spaceBtwSections,
                  )
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(NSizes.defaultSpacing),
              child: Column(
                children: [
                  const NSectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: NSizes.spaceBtwItems,
                  ),
                  NSettingsMenuTile(
                    title: 'My Address',
                    icon: Iconsax.safe_home,
                    subTitle: 'Set Shopping delivery Address',
                    onTap: ()=>Get.to(UserAddressScreen()),
                  ),
                  NSettingsMenuTile(
                    title: 'My Cart',
                    icon: Iconsax.shopping_cart,
                    subTitle: 'Add , remove products and move to checkOut',
                    onTap: () {},
                  ),
                  NSettingsMenuTile(
                    title: 'My Orders',
                    icon: Iconsax.bag_tick,
                    subTitle: 'In-progress and completed order',
                    onTap: () => Get.to(()=> const OrderScreen()),
                  ),
                  NSettingsMenuTile(
                    title: 'Bank Account',
                    icon: Iconsax.bank,
                    subTitle: 'Withdraw balance to registered bank account',
                    onTap: () {},
                  ),
                  NSettingsMenuTile(
                    title: 'My Coupons',
                    icon: Iconsax.discount_shape,
                    subTitle: 'List of all discounted coupon',
                    onTap: () {},
                  ),
                  NSettingsMenuTile(
                    title: 'Notifications',
                    icon: Iconsax.notification,
                    subTitle: 'Set any kind of notification message',
                    onTap: () {},
                  ),
                  NSettingsMenuTile(
                    title: 'Account Privacy',
                    icon: Iconsax.security_card,
                    subTitle: 'Manage data usage and connect',
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: NSizes.spaceBtwSections,
                  ),

                  ///App Settings
                  const NSectionHeading(
                    title: 'App Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: NSizes.spaceBtwItems,
                  ),
                   NSettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Load Data',
                    subTitle: 'Upload Data to your cloud firebase',
                    onTap: (){ Get.to(const UploadDataScreen());},
                  ),
                  NSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'GeoLocation',
                    subTitle: 'Set recommendation based on location',
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  NSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  NSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD image quality',
                    subTitle: 'Set image quality to be seen',
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),

                  ///Logout Button
                  const SizedBox(
                    height: NSizes.spaceBtwSections,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Logout'),
                    ),
                  ),
                  const SizedBox(
                    height: NSizes.spaceBtwSections * 2.5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

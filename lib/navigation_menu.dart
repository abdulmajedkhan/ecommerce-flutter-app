import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';
import 'package:nomishop/features/Shop/screens/cart/cart_screen.dart';
import 'package:nomishop/features/Shop/screens/home/home.dart';
import 'package:nomishop/features/Shop/screens/wishlists/wish_list.dart';
import 'package:nomishop/features/personilzation/views/profile_screen/widgets/settings.dart';
import 'package:nomishop/util/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(NavigationController());
    final darkMode = NHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: darkMode ? Colors.black : Colors.white,
          destinations: const [
            NavigationDestination(
                icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Iconsax.heart), label: 'Wish List'),
            NavigationDestination(
                icon: Icon(Iconsax.card_tick), label: 'Cart'),
            NavigationDestination(
                icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    const WishList(),
   CartScreen(),
    const SettingsScreen(),
  ];
}

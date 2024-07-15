
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/Shop/controllers/product/favorites_controller.dart';
import '../../icons/n_circular_icon.dart';

class NFavoriteIcon extends StatelessWidget {
  const NFavoriteIcon({
    super.key, required this.productId,
  });
final String productId;
  @override
  Widget build(BuildContext context) {
    final  controller = Get.put(FavoritesController());
    return Obx(
          () {
        print('Favorites: ${controller.favorites}');
        return NCircularIcon(
          icon: controller.isFavorite(productId) ? Iconsax.heart5 : Iconsax.heart,
          color: controller.isFavorite(productId) ? Colors.red : null,
          onPressed: () => controller.toggleFavoriteProduct(productId),
        );
      },
    );

  }
}
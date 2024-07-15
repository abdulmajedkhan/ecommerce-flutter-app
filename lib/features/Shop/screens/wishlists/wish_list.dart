import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nomishop/common/widgets/icons/n_circular_icon.dart';
import 'package:nomishop/common/widgets/layouts/grid_layout.dart';
import 'package:nomishop/common/widgets/list_tiles/animation_loader.dart';
import 'package:nomishop/common/widgets/products/productcards/vertical_product_card.dart';
import 'package:nomishop/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:nomishop/features/Shop/controllers/product/favorites_controller.dart';
import 'package:nomishop/features/Shop/screens/home/home.dart';

import '../../../../navigation_menu.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/n_cloud_helper_fucntions.dart';

class WishList extends StatelessWidget {
  const WishList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller =Get.put(FavoritesController());
    return Scaffold(
      appBar: AppBar(

        title: Text(
          'WishList',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          NCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(() => const HomeScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(NSizes.defaultSpacing),
          child: Obx(
         ()=> FutureBuilder(
              future: controller.favoriteProducts(),
              builder: (context, snapshot) {
                // nothing found widgets
                final emptyWidget = NAnimationLoaderWidget(
                    text: 'whoops wishlist is empty',
                    animation: 'assets/images/animations/docerAnimation.json',
               showAction: true,
                  actionText: 'Let\'s add some',
                  onActionPressed: ()=> Get.off(()=> const NavigationMenu()),
                );
                const loader=NVerticalProductShimmer(itemCount: 6,);
                final widget =NCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader, nothingFound: emptyWidget);
                if(widget != null) return widget;

                final products = snapshot.data!;
                return NGridLayout(
                    itemCount: products.length,
                    itemBuilder: (_, index) => NProductCardVertical(
                          product: products[index],
                        ));
              },
            ),
          ),
        ),
      ),
    );
  }
}

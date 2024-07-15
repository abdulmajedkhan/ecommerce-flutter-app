import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nomishop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:nomishop/common/widgets/list_tiles/animation_loader.dart';
import 'package:nomishop/features/Shop/controllers/product/oder_controller.dart';
import 'package:nomishop/navigation_menu.dart';
import 'package:nomishop/util/constants/sizes.dart';
import 'package:nomishop/util/helpers/helper_functions.dart';
import 'package:nomishop/util/helpers/n_cloud_helper_fucntions.dart';

import '../../../../../util/constants/colors.dart';

class NOrderListItems extends StatelessWidget {
  const NOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (_, snapshot) {
        /// nothing found widget
        final emptyWidget = NAnimationLoaderWidget(
            text: 'Whoops! No order yet',
            animation: 'assets/images/animations/docerAnimation.json',
        showAction: true,
          actionText: 'Let\'s Fill it',
          onActionPressed: ()=>Get.to(()=> const NavigationMenu()),
        );
        final response= NCloudHelperFunctions.checkMultiRecordState(snapshot:snapshot , nothingFound: emptyWidget);
        if(response!=null) return response;

        final orders=snapshot.data!;
        return ListView.separated(
          separatorBuilder: (_, __) => const SizedBox(
            height: NSizes.spaceBtwItems,
          ),
          itemCount: 4,
          itemBuilder: (_, index) {
            final order=orders[index];
            return NRoundedContainer(
            showBorder: true,
            backgroundColor: NHelperFunctions.isDarkMode(context)
                ? NColors.dark
                : NColors.light,
            child: Padding(
              padding: const EdgeInsets.all(NSizes.md),
              child: Column(
                children: [
                  ///Row1
                  Row(
                    children: [
                      /// 1-icon
                      const Icon(Iconsax.ship),
                      const SizedBox(
                        width: NSizes.spaceBtwItems,
                      ),

                      ///2- status and date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              order.orderStatusText,
                              style: Theme.of(context).textTheme.bodyLarge!.apply(
                                  color: NColors.primary, fontWeightDelta: 1),
                            ),
                            Text(
                              order.formattedOrderDate,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),

                      /// 3-Icon
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Iconsax.arrow_right_34,
                            size: NSizes.iconsSm,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: NSizes.spaceBtwItems,
                  ),

                  /// Row-2
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            /// 1-icon
                            const Icon(Iconsax.tag),
                            const SizedBox(
                              width: NSizes.spaceBtwItems / 2,
                            ),

                            ///2- status and date
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Order',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium),
                                  Text(
                                    order.id,
                                    style:
                                    Theme.of(context).textTheme.titleMedium,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            /// 1-icon
                            const Icon(Iconsax.calendar),
                            const SizedBox(
                              width: NSizes.spaceBtwItems / 2,
                            ),

                            ///2- status and date
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Shipping DAte',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium),
                                  Text(
                                    order.formattedDeliveryDate,
                                    style:
                                    Theme.of(context).textTheme.titleMedium,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  ///Row 3
                ],
              ),
            ),
          );}
        );
      },
    );
  }
}

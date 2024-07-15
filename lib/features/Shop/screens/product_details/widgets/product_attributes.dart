import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomishop/common/widgets/choice_chip/choice_chip.dart';
import 'package:nomishop/common/widgets/section_heading/section_heading.dart';
import 'package:nomishop/features/Shop/controllers/product/variation_controller.dart';
import 'package:nomishop/features/Shop/models/poduct_model.dart';

class NProductAttributes extends StatelessWidget {
  const NProductAttributes({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationController());
    return Column(
      children: [
        if (controller.selectedVariation.value.id.isNotEmpty)

          /// Attribute
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map((attribute) => Column(
                      children: [
                        NSectionHeading(
                          title: attribute.name ?? '',
                          showActionButton: false,
                        ),
                        Obx(
                          ()=> Wrap(
                            spacing: 8,
                            children: attribute.values!.map(
                              (attributeValue) {
                                final isSelected = controller
                                        .selectedAttributes[attribute.name] ==
                                    attributeValue;
                                final available = controller
                                    .getAttributeAvailabilityInVariation(
                                        product.productVariations!,
                                        attribute.name!)
                                    .contains(attributeValue);

                                return NChoiceChip(
                                  text: attributeValue,
                                  selected: isSelected,
                                  onSelected: available
                                      ? (selected) {
                                          if (selected && available) {
                                            controller.onAttributeSelected(
                                                product,
                                                attribute.name ?? '',
                                                attributeValue);
                                          }
                                        }
                                      : null,
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ],
                    ))
                .toList(),
          ),
        // Column(
        //   children: [
        //     NSectionHeading(
        //       title: 'Size',
        //       showActionButton: false,
        //     ),
        //     Wrap(
        //       spacing: 8,
        //       children: [
        //         NChoiceChip(
        //           text: 'EU 34',
        //           selected: true,
        //           onSelected: (value) {},
        //         ),
        //         NChoiceChip(
        //           text: 'EU 36',
        //           selected: false,
        //           onSelected: (value) {},
        //         ),
        //         NChoiceChip(
        //           text: 'EU 38',
        //           selected: false,
        //           onSelected: (value) {},
        //         ),
        //       ],
        //     )
        //   ],
        // )
      ],
    );
  }
}

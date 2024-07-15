
import 'package:flutter/material.dart';
import 'package:nomishop/common/widgets/shimmer/n_shimmer_effect.dart';
import 'package:nomishop/util/constants/sizes.dart';
class NCategoryShimmer extends StatelessWidget {
  const NCategoryShimmer({super.key, this.itemCount=6});
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        separatorBuilder:(_, __)=> const SizedBox(width: NSizes.spaceBtwItems,),
        itemCount: itemCount, itemBuilder: (_, __){
          return const Column(
            children: [
              /// image
             NShimmerEffect(width: 55,height: 55,radius: 55,) ,
              SizedBox(
                height: NSizes.spaceBtwItems/2,
              ),
              /// text
              NShimmerEffect(width: 55, height: 8),


            ],
          );
      },),
    );
  }
}

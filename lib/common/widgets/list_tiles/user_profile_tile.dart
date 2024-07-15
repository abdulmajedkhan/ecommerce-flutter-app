import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nomishop/features/personilzation/controllers/user_controller.dart';
import 'package:nomishop/features/personilzation/views/profile_screen/profile.dart';
import 'package:nomishop/util/constants/colors.dart';

import '../custom_shapes/round-image/circular_image.dart';
class NUserProfileTile extends StatelessWidget {
  const NUserProfileTile({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    final controller= UserController.instance;
    return ListTile(
      leading:Obx(() {
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
      title: Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.white),),
      subtitle: Text(controller.user.value.email, style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),),
      trailing: IconButton(onPressed: ()=>Get.to(()=>const ProfileScreen()),icon: const Icon(Iconsax.edit, color: NColors.white,),),
    );
  }
}
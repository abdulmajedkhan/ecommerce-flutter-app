import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomishop/navigation_menu.dart';
import 'package:nomishop/util/constants/sizes.dart';
class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, this.onPressed});
final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    body:Padding(
      padding: const EdgeInsets.all(NSizes.defaultSpacing),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text('Your account is successfully ', style: Theme.of(context).textTheme.headlineMedium,),
            Text('created!',style: Theme.of(context).textTheme.headlineMedium,),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: ()=>Get.to(const NavigationMenu()), child: const Text('Continue'))),
          ],
        ),
    ),
    );
  }
}


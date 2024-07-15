import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomishop/data/repositries/authentication/authentication_repository.dart';
import 'package:nomishop/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:nomishop/util/constants/sizes.dart';

class EmailVerification extends StatelessWidget {
  const  EmailVerification({super.key, this.email});
final String? email;
  @override
  Widget build(BuildContext context) {
    final controller =Get.put( VerifyEmailController());
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: ()=>Get.offAll(()=>AuthenticationRepository.instance.logout()), icon: const Icon(CupertinoIcons.clear))
      ],),
      body: Padding(
        padding: const EdgeInsets.all(NSizes.defaultSpacing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Verify your email'),
            const SizedBox(height: NSizes.spaceBtwItems),
            Text(email ?? ' ', style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center,),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () =>controller.checkEmailVerificationStatus(), child: const Text('Continue'))),
            const SizedBox(height: NSizes.spaceBtwItems/2,),
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(onPressed: ()=> controller.sendEmailVerification(), child: const Text('Resend Email'))),
          ],
        ),
      ),
    );
  }
}

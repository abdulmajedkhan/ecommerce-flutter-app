import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nomishop/app.dart';
import 'package:nomishop/features/Shop/screens/checkout/checkout.dart';
import 'package:nomishop/features/personilzation/controllers/address_controller.dart';
import 'package:nomishop/util/validators/validators.dart';

import '../../../../../util/constants/sizes.dart';
class AddNewAddress extends StatelessWidget {
  const AddNewAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller= AddressController.instance;
    return Scaffold(
      appBar: AppBar(

        title: Text('Add Address'),
      ),
     body:  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(NSizes.defaultSpacing),
          child: Form(
              key: controller.addressFormKey,
              child: Column(
            children: [
              TextFormField(
                validator: (value) =>
                    NValidators.validateEmptyText('Name', value),
                controller: controller.name,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.user),
                  labelText: 'Name',


                ),
              ),
              const SizedBox(height: NSizes.spaceBtwInputFields,),
              TextFormField(
                controller: controller.phoneNumber,
                 validator: (value) => NValidators.validatePhoneNumber(value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.mobile),
                  labelText: 'Phone Number'
                ),
              ),
              const SizedBox(height: NSizes.spaceBtwInputFields,),
              Row(children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.street,
                    validator: (value) =>
                        NValidators.validateEmptyText('Street', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.building_31),
                        labelText: 'Street'
                    ),
                  ),
                ),
                const SizedBox(width: NSizes.spaceBtwInputFields,),
                Expanded(
                  child: TextFormField(
                    controller: controller.postalCode,
                    validator: (value) =>
                        NValidators.validateEmptyText('Postal code', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.code),

                        labelText: 'Postal Code'
                    ),
                  ),
                ),
              ],),
              const SizedBox(height: NSizes.spaceBtwInputFields,),  Row(children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.city,
                    validator: (value) =>
                        NValidators.validateEmptyText('City', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.building),
                        labelText: 'City'
                    ),
                  ),
                ),
                const SizedBox(width: NSizes.spaceBtwInputFields,),
                Expanded(
                  child: TextFormField(
                    controller: controller.state,
                    validator: (value) =>
                        NValidators.validateEmptyText('State', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.activity),
                        labelText: 'State'
                    ),
                  ),
                ),
              ],),
              const SizedBox(height: NSizes.spaceBtwInputFields,),
              TextFormField(
                controller: controller.country,
                validator: (value) =>
                    NValidators.validateEmptyText('Country', value),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.global),
                    labelText: 'Country'
                ),
              ),
              SizedBox(height: NSizes.spaceBtwSections,),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: ()=>controller.addNewAddress(), child: const Text('Save')))
            ],
          )),
        ),
      ),
    );

  }
}

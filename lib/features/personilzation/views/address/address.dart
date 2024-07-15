import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nomishop/features/personilzation/controllers/address_controller.dart';
import 'package:nomishop/features/personilzation/views/address/widgets/single_address.dart';
import 'package:nomishop/util/helpers/n_cloud_helper_fucntions.dart';

import '../../../../util/constants/sizes.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(NSizes.defaultSpacing),
        child: Obx(
          () => FutureBuilder(
            key: Key(controller.refreshData.value.toString()),
            future: controller.getAllUserAddresses(),
            builder: (context, snapshot) {
              final response = NCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot);
              if (response != null) return response;
              final addresses = snapshot.data;
              return ListView.builder(
                itemCount: addresses!.length,
                itemBuilder: (_, index) => SingleAddress(
                    onTap: () => controller.selectedAddress(addresses[index]),
                    address: addresses[index]),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>controller.addNewAddress(),
        child: Icon(Iconsax.add),
      ),
    );
  }
}

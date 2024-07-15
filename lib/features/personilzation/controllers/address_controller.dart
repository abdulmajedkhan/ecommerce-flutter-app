

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nomishop/common/widgets/section_heading/section_heading.dart';
import 'package:nomishop/data/repositries/address/address_repository.dart';
import 'package:nomishop/data/services/netwotk_manager.dart';
import 'package:nomishop/features/personilzation/models/address_model.dart';
import 'package:nomishop/features/personilzation/views/address/widgets/add_new_address.dart';
import 'package:nomishop/features/personilzation/views/address/widgets/single_address.dart';
import 'package:nomishop/util/constants/sizes.dart';
import 'package:nomishop/util/helpers/n_cloud_helper_fucntions.dart';
import 'package:nomishop/util/popups/full_screen_loader.dart';
import 'package:nomishop/util/popups/loaders.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name=TextEditingController();
  final phoneNumber=TextEditingController();
  final street=TextEditingController();
  final postalCode=TextEditingController();
  final city=TextEditingController();
  final state=TextEditingController();
  final country=TextEditingController();
  GlobalKey<FormState> addressFormKey=GlobalKey<FormState>();

  RxBool refreshData=true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      NLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }

  Future<void> selectAddress(AddressModel newSelectedAddress) async {
    try {

      Get.defaultDialog(
        title: '',
        onWillPop: () async{return false;},
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        confirm: const CircularProgressIndicator(),
      );
     // clear the selected field
      if(selectedAddress.value.id.isNotEmpty){
        await addressRepository.updateSelectedField(selectedAddress.value.id, false);
      }


     newSelectedAddress.selectedAddress=true;
      selectedAddress.value=newSelectedAddress;

      await addressRepository.updateSelectedField(selectedAddress.value.id, true);
      Get.back();
      // Notify the user of success (optional)
      NLoaders.successSnackBar(
          title: 'Address Selected',
          message: 'Selected address updated successfully.');
    } catch (e) {
      // Handle errors and show a snackbar
      NLoaders.errorSnackBar(
          title: 'Failed to select address', message: e.toString());
    }
  }
  Future<void> addNewAddress() async {
    try {

      NFullScreenLoader.openLoadingDialog('Saving Address...', 'assets/images/animations/loaderAnimation.json');

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        NFullScreenLoader.stopLoading();
        NLoaders.errorSnackBar(title: 'No Internet', message: 'Please check your internet connection.');
        return;
      }

      // Form Validation
      if (!addressFormKey.currentState!.validate()) {
        NFullScreenLoader.stopLoading();
        return;
      }

      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        city: city.text.trim(),
        selectedAddress: true,
      );

      final id = await addressRepository.addAddress(address);
      address.id = id;

      await selectAddress(address);

      // Reset fields
      refreshData.toggle();
      resetFormFields();

      // Redirect
      Get.back();

      NFullScreenLoader.stopLoading();

    } catch (e) {
      NFullScreenLoader.stopLoading();
      NLoaders.errorSnackBar(title: 'Failed to Add Address', message: e.toString());
    }
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context){
    return showModalBottomSheet(context: context, builder: (_)=>Container(
      padding:  const EdgeInsets.all(NSizes.lg),
      child: Column(
        children: [
          const NSectionHeading(title: 'SelectAddress', showActionButton: false,),
          FutureBuilder(future: getAllUserAddresses(), builder: (__, snapshot){
            final response = NCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
            if(response!=null) return response;
            return Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index)=>SingleAddress(
                    address: snapshot.data![index],
                    onTap: () async{
                      await selectAddress(snapshot.data![index]);
                      Get.back();
                    },
                  )),
            );
          }),
          const SizedBox(height: NSizes.defaultSpacing*2,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: ()=>Get.to(()=> const AddNewAddress(),
              ),
              child: const Text('Add new Address'),
            ),

          )
        ],
      ),
    ));
  }


  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();

  }
}



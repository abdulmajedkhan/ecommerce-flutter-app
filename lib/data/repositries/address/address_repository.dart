
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nomishop/data/repositries/authentication/authentication_repository.dart';

import '../../../features/personilzation/models/address_model.dart';

class AddressRepository extends GetxController{
  static AddressRepository get instance=>Get.find();
  final _db=FirebaseFirestore.instance;
  
  
  Future<List<AddressModel>> fetchUserAddresses() async{
    try{
      final userId= AuthenticationRepository.instance.authUser!.uid;
      if(userId.isEmpty) throw 'Unable to find the user information. try again in few minutes';
      final result= await _db.collection('Users').doc(userId).collection('Addresses').get();
      return result.docs.map((documentSnapshot)=> AddressModel.fromDocumentSnapshot(documentSnapshot)).toList();
    } catch(e){
      throw 'Something went wrong while fetching address information. Try again later';
    }


  }
  Future<void> updateSelectedField(String addressId, bool selected) async{
    try{
      final userId= AuthenticationRepository.instance.authUser!.uid;
      await _db.collection('Users').doc(userId).collection('Addresses').doc(addressId).update(
          {'selectedAddress': selected});
    } catch(e){
    throw 'Unable to update you address selection. Try again late.'  ;
    }


  }
  Future<String> addAddress(AddressModel address) async{
    try{
      final userId= AuthenticationRepository.instance.authUser!.uid;
      final currentAddress= await _db.collection('Users').doc(userId).collection('Addresses').add(address.toJson());
      return currentAddress.id;
    } catch(e){
      throw 'Something went wrong while saving your address information, Tey again late.';
    }
  }


}
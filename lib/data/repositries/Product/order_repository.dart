import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nomishop/data/repositries/authentication/authentication_repository.dart';

import '../../../features/Shop/models/order_model.dart';

class OrderRepository extends GetxController{
  static OrderRepository get instance=> Get.find();

  /// Variable
  final _db=FirebaseFirestore.instance;


  Future<List<OrderModel>> fetchUserOrders() async{
    try{
      final userId= AuthenticationRepository.instance.authUser?.uid;
      if(userId!.isEmpty) throw 'Unable to find the user information';

      final result= await _db.collection('Users').doc(userId).collection('Orders').get();
      return result.docs.map((documentSnapshot)=> OrderModel.fromSnapshot(documentSnapshot)).toList();

    } catch(e){
      throw 'Something went wrong while fetching your order information. Try again later';
    }
  }

  /// Store a new user record
 Future<void> saveOrder(OrderModel order, String userId) async{
    try{
      await _db.collection('Users').doc(userId).collection('Orders').add(order.toJson());
    } catch (e){
      // throw 'Something went wrong while saving order information. Try again later';
    }
 }
}
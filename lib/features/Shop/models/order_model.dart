

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nomishop/util/constants/enums.dart';
import 'package:nomishop/util/helpers/n_cloud_helper_fucntions.dart';

import '../../../util/helpers/helper_functions.dart';
import '../../personilzation/models/address_model.dart';
import 'cart_model.dart';

class OrderModel{
  final String id;
  final String userId;
  final orderStore;
  final totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;
  final OrderStatus status;

  OrderModel( {
    required this.id,
    required this.userId,
    this.orderStore,
    this.totalAmount,
    required this.orderDate,
    required this.paymentMethod,
    this.address,
    this.deliveryDate,
    required this.items,
    required this.status,
});
  String get formattedOrderDate=> NHelperFunctions.getFormattedDate(orderDate);
  String get formattedDeliveryDate => deliveryDate!= null? NHelperFunctions.getFormattedDate(deliveryDate!): '';
  String get orderStatusText=>status==OrderStatus.delivered? 'Delivered' : status==OrderStatus.shipped? 'Shipment on the way':'Processing';
  // Convert OrderModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(),

      'totalAmount': totalAmount,
      'orderDate': orderDate.toIso8601String(),
      'paymentMethod': paymentMethod,
      'address': address?.toJson(),
      'deliveryDate': deliveryDate?.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  // Convert JSON to OrderModel
  // factory OrderModel.fromJson(Map<String, dynamic> json) {
  //   return OrderModel(
  //
  //     id: json['id'] ,
  //     userId: json['userId'],
  //     orderStore: json['orderStore'],
  //     totalAmount: json['totalAmount'],
  //     orderDate: DateTime.parse(json['orderDate']),
  //     paymentMethod: json['paymentMethod'],
  //     address: json['address'] != null ? AddressModel.fromMap(json['address']) : null,
  //     deliveryDate: json['deliveryDate'] != null ? DateTime.parse(json['deliveryDate']) : null,
  //     items: (json['items'] as List).map((item) => CartItemModel.fromJson(item)).toList(),
  //   );
  // }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      id: data['id']as String,
      userId: data['userId'] as String,
      status: OrderStatus.values.firstWhere((e)=> e.toString() == data['status']),

      totalAmount: data['totalAmount'] as double,
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      paymentMethod: data['paymentMethod'] as String,
      address: data['address'] != null ? AddressModel.fromMap(data['address']) : null,
      deliveryDate: data['deliveryDate'] != null ? (data['deliveryDate'] as Timestamp).toDate() : null,
      items: (data['items'] as List<dynamic>).map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }

}
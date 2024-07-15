import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nomishop/util/formatters/formatters.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.selectedAddress = true,
  });
  get formattedPhoneNo => NFormatters.formatPhoneNumbers(phoneNumber);
  static AddressModel empty() => AddressModel(
      id: '',
      name: '',
      phoneNumber: '',
      street: '',
      city: '',
      state: '',
      postalCode: '',
      country: '');
  // Convert AddressModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'dateTime': DateTime.now(),
      'selectedAddress': selectedAddress,
    };
  }

  // Convert Map to AddressModel
  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      street: map['street'],
      city: map['city'],
      state: map['state'],
      postalCode: map['postalCode'],
      country: map['country'],
      dateTime: (map['dateTime'] as Timestamp).toDate(),
      selectedAddress: map['selectedAddress'],
    );
  }

  // Convert Firestore DocumentSnapshot to AddressModel
  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return AddressModel(
      id: snapshot.id,
      name: data['name'],
      phoneNumber: data['phoneNumber'],
      street: data['street'],
      city: data['city'],
      state: data['state'],
      postalCode: data['postalCode'],
      country: data['country'],
      dateTime: (data['dateTime'] as Timestamp).toDate(),
      selectedAddress: data['selectedAddress'],
    );
  }

  @override
  String toString() {
    return '$street, $city, $state, $postalCode, $country';
  }
}

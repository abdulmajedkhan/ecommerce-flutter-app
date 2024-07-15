import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nomishop/util/formatters/formatters.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.email,
      required this.phoneNumber,
      required this.profilePicture});

  ///Helper Function to get full Name
  String get fullName => '$firstName $lastName';

  /// static function to split full name into first and last
  static List<String> nameParts(String fullName) => fullName.split(' ');

  ///Helper Function to format phone number
  String get formattedPhoneNo => NFormatters.formatPhoneNumbers(phoneNumber);

  /// static function to generate a user name from the full name.
  static String generateUserName(fullName) {
    List<String> nameParts = fullName.split(' ');
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : '';
    String camelCaseUsername = '$firstName$lastName';
    String usernameWithPrefix = 'cwt_$camelCaseUsername';
    return usernameWithPrefix;
  }

  /// static function to create empty user model.
  static UserModel empty() => UserModel(
      id: '',
      username: '',
      email: '',
      firstName: '',
      phoneNumber: '',
      lastName: '',
      profilePicture: '');

  /// convert model into jason structure for storing data in firestore
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  /// factory method to create a userModel from a firebase documnet snapshot
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }

}

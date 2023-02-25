import 'package:mongo_dart/mongo_dart.dart';
import 'Address.dart';

class User {
  final ObjectId id;
  final String userID;
  late final String name;
  late final String password;
  final String passhint;
  final Address address;
  late final String email;
  final String dob;
  final String mobileno1;
  String mobileno2 = '0092';

  User(
      {required this.id,
      required this.userID,
      required this.name,
      required this.password,
      required this.passhint,
      required this.address,
      required this.email,
      required this.dob,
      required this.mobileno1,
      this.mobileno2 = '0092'});

// Code
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'userID': userID,
      'name': name,
      'password': password,
      'passhint': passhint,
      'address': address.toMap(),
      'email': email,
      'dob': dob,
      'mobileno1': mobileno1,
      'mobileno2': mobileno2
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        id = map['_id'],
        userID = map['userID'],
        password = map['password'],
        passhint = map['passhint'],
        address = Address.fromMap(map['address']),
        email = map['email'],
        dob = map['dob'],
        mobileno1 = map['mobileno1'],
        mobileno2 = map['mobileno2'];
}

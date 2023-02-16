// ignore: file_names

import 'package:mongo_dart/mongo_dart.dart';

class Address {
  final ObjectId id;
  final String houseNo;
  final String streetline1;
  String streetline2 = 'Unknown';
  final String city;
  final String state;
  final String country;
  String postcode = 'Unknow';
  String latitude = '0.00';
  String longitude = '0.00';
  bool defaultAddress = true;

  Address(
      {required this.id,
      required this.houseNo,
      required this.streetline1,
      required this.city,
      required this.state,
      required this.country,
      this.streetline2 = 'Unknown',
      this.postcode = '000000',
      this.latitude = '0.00',
      this.longitude = '0.00',
      this.defaultAddress = true});

// Code
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'houseNo': houseNo,
      'streetline1': streetline1,
      'city': city,
      'state': state,
      'country': country,
      'streetline2': streetline2,
      'postcode': postcode,
      'latitude': latitude,
      'longitude': longitude,
      'defaultAdress': defaultAddress
    };
  }

  Address.fromMap(Map<String, dynamic> map)
      : houseNo = map['houseNo'],
        id = map['_id'],
        streetline1 = map['streetline1'],
        city = map['city'],
        state = map['state'],
        country = map['country'],
        streetline2 = map['streetline2'],
        postcode = map['postcode'],
        latitude = map['latitude'],
        longitude = map['longitude'],
        defaultAddress = map['defaultAddress'];
}

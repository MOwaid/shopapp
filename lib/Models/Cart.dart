// ignore: file_names
// ignore: file_names

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:shopapp/Models/DBHelper.dart';

import 'Product.dart';

class Cartitem {
  final ObjectId id;
  ObjectId productId;
  String productName;
  String productExtra;
  double initialPrice;
  double productPrice;
  int quantity;
  String image;
  Cartitem(
      {required this.id,
      required this.productId,
      required this.productName,
      required this.productExtra,
      required this.initialPrice,
      required this.productPrice,
      required this.quantity,
      required this.image});

  Cartitem.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        productId = map['productId'],
        productName = map['productName'],
        productExtra = map['productExtra'],
        initialPrice = map['initialPrice'],
        productPrice = map['productPrice'],
        quantity = map['quantity'],
        image = map['image'];

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'productId': productId,
      'productName': productName,
      'productExtra': productExtra,
      'initialPrice': initialPrice,
      'productPrice': productPrice,
      'quantity': quantity,
      'image': image
    };
  }
}

class CartOne with ChangeNotifier {
  ObjectId id;
  int totalQuantity;
  double totalPrice;
  final List<Cartitem> items;
  double vat;
  double posCharges;
  DateTime orderdate;
  final String userID;
  final String username;
  final String userAddress;
  double Alatitude;
  double Alongitude;
  int orderStatus;
  String riderID;
  String managerID;
  int itemcount = 0;
  String note;

  CartOne(
      {required this.id,
      required this.totalQuantity,
      required this.totalPrice,
      required this.items,
      required this.vat,
      required this.posCharges,
      required this.orderdate,
      required this.userID,
      required this.username,
      required this.userAddress,
      required this.Alatitude,
      required this.Alongitude,
      required this.orderStatus,
      required this.riderID,
      required this.managerID,
      required this.note});

  List<Map<String, Object>> toitemsMap() {
    return items.map((e) {
      return {
        "_id": e.id,
        "productId": e.productId,
        "productName": e.productName,
        "productExtra": e.productExtra,
        "initialPrice": e.initialPrice,
        "productPrice": e.productPrice,
        "quantity": e.quantity,
        "image": e.image
      };
    }).toList();
  }

  CartOne.fromMap(Map<dynamic, dynamic> map)
      : id = map['_id'],
        totalQuantity = map['totalQuantity'],
        totalPrice = map['totalPrice'],
        items = (map['items'] as List)
            .map((itemWord) => Cartitem.fromMap(itemWord))
            .toList(),
        vat = map['vat'],
        posCharges = map['posCharges'],
        orderdate = map['orderdate'],
        userID = map['userID'],
        username = map['username'],
        userAddress = map['userAddress'],
        Alatitude = map['Alatitude'],
        Alongitude = map['Alongitude'],
        orderStatus = map['orderStatus'],
        riderID = map['riderID'],
        managerID = map['managerID'],
        note = map['note'];

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'totalQuantity': totalQuantity,
      'totalPrice': totalPrice,
      'items': toitemsMap(),
      'vat': vat,
      'posCharges': posCharges,
      'orderdate': orderdate,
      'userID': userID,
      'username': username,
      'userAddress': userAddress,
      'Alatitude': Alatitude,
      'Alongitude': Alongitude,
      'orderStatus': orderStatus,
      'riderID': riderID,
      'managerID': managerID,
      'note': note
    };
  }

  getFormattedDateFromFormattedString(
      {required value,
      required String currentFormat,
      required String desiredFormat,
      isUtc = false}) {
    DateTime? dateTime = DateTime.now();
    if (value != null || value.isNotEmpty) {
      try {
        dateTime = DateFormat(currentFormat).parse(value, isUtc).toLocal();
      } catch (e) {
        print("$e");
      }
    }
    return dateTime;
  }

  void itemAdd() {
    itemcount++;
    notifyListeners();
  }

  void itemCountChange() {
    notifyListeners();
  }

  void itemremoved() {
    if (itemcount > 0) {
      itemcount--;
      notifyListeners();
    }
  }
}

/*
 var data = "2021-12-15T11:10:01.521Z";

  DateTime dateTime = getFormattedDateFromFormattedString(
      value: data,
      currentFormat: "yyyy-MM-ddTHH:mm:ssZ",
      desiredFormat: "yyyy-MM-dd HH:mm:ss");
  
  print(dateTime); //2021-12-15 11:10:01.000
  */

Cartitem item = Cartitem(
    id: M.ObjectId(),
    productId: M.ObjectId(),
    productName: "itemname",
    productExtra: "itemExtra",
    initialPrice: 0.00,
    productPrice: 0.00,
    quantity: 1,
    image: "no image");
/*
CartOne userCart = CartOne(
    id: M.ObjectId(),
    totalQuantity: 0,
    totalPrice: 0.00,
    items: [],
    vat: 0.00,
    posCharges: 0.00,
    orderdate: "2021-12-15 11:10:01.000",
    userID: DBHelper.currentUser.userID,
    username: DBHelper.currentUser.name,
    userAddress: DBHelper.currentUser.address.streetline1,
    Alatitude: DBHelper.currentUser.address.latitude,
    Alongitude: DBHelper.currentUser.address.longitude,
    orderStatus: 1,
    riderID: "1",
    managerID: "1");
*/
List<CartOne> userorders = [];
List<CartOne> useropenorders = [];
//List<Cartitem> cartItems = [];

// ignore: file_names

import 'dart:async';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shopapp/Models/Product.dart';
import '../utils/Constants.dart';
import 'Cart.dart';
import 'User.dart';

class DBHelper {
  // ignore: prefer_typing_uninitialized_variables
  static var db, userCollection, userOrders, productcollection;
  static late User currentUser;

// ignore: non_constant_identifier_names
  get database async {
    if (db != null) {
      return db!;
    }
    db = await initDatabase();
    return null;
  }

  static initDatabase() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    return db;
  }

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    userCollection = db.collection(USER_COLLECTION);
    productcollection = db.collection(PRODUCT_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getDocuments() async {
    try {
      final users = await userCollection.find().toList();
      return users;
    } catch (e) {
      print(e);
      return Future.value(e as FutureOr<List<Map<String, dynamic>>>?);
    }
  }

  static Future<List<Map<String, dynamic>>> getproductCollections() async {
    try {
      final products = await productcollection.find().toList();

      products.forEach((element) {
//------------------------here we converting json string to map object-------
        Product ma = Product.fromMap(element);
        demoProducts.add(ma);
      });

      return products;
    } catch (e) {
      print(e);
      return Future.value(e as FutureOr<List<Map<String, dynamic>>>?);
    }
  }

  static Future<List<Map<String, dynamic>>> getOrderCollections() async {
    try {
      final cartOne = await userOrders.find().toList();

      cartOne.forEach((element) {
//------------------------here we converting json string to map object-------
        CartOne ma = CartOne.fromMap(element);
        userorders.add(ma);
      });

      return cartOne;
    } catch (e) {
      print(e);
      return Future.value(e as FutureOr<List<Map<String, dynamic>>>?);
    }
  }

  static Future<bool> fuser(String username, String password) async {
    try {
      List userlist = await userCollection
          .find({'userID': username, 'password': password}).toList();
      if (userlist.isNotEmpty) {
        currentUser = User.fromMap(userlist[0]);
      } else {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }

// Now you can iterate on this list.
//for (var task in dailyTaskList) {
    // do something
  }

  static Future<bool> finduser(String username) async {
    try {
      List userlist = await userCollection.find({'userID': username}).toList();
      if (userlist.isNotEmpty) {
        currentUser = User.fromMap(userlist[0]);
      } else {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  static insert(User user) async {
    try {
      await userCollection.insertAll([user.toMap()]);

      return true;
    } catch (e) {
      return false;
    }
  }

  static insertProduct(Product product) async {
    try {
      await productcollection.insertAll([product.toMap()]);
      return true;
    } catch (e) {
      return false;
    }
  }

  static update(User user) async {
    var u = await userCollection.findOne({"_id": user.id});
    u["name"] = user.name;
    u["userID"] = user.userID;
    u["password"] = user.password;
    u["passhint"] = user.passhint;
    u["address"] = user.address;
    u["email"] = user.email;
    u["dob"] = user.dob;
    u["mobileno1"] = user.mobileno1;
    u["mobileno2"] = user.mobileno1;

    await userCollection.save(u);
  }

  static delete(User user) async {
    await userCollection.remove(where.id(user.id));
  }

  // inserting data into the table
  static Future<CartOne> insertCart(CartOne cart) async {
    await userOrders.insertAll([cart.toMap()]);

    return cart;
  }
// getting all the items in the list from the database

  Future<List<CartOne>> getOrdertList() async {
    try {
      final cart = await userOrders.find().toList();
      return cart;
    } catch (e) {
      print(e);
      return Future.value(e as FutureOr<List<CartOne>>?);
    }
  }

  static updateQuantity(CartOne cart) async {
    var c = await userOrders.findOne({"_id": cart.id});
    c["totalQuantity"] = cart.totalQuantity;
    await userOrders.save(c);
  }

// deleting an item from the cart screen

  static deleteCartItem(CartOne cart) async {
    await userOrders.remove(where.id(cart.id));
  }
}

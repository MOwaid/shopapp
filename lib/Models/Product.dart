import 'dart:collection';
import 'dart:core';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:mongo_dart/mongo_dart.dart';
import 'ProductVariation.dart';

class Product {
  final ObjectId id;
  final String title, description;
  final List<String> images;
  final List<ProductVariation> variation;
  final double rating;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.images,
    required this.variation,
    this.rating = 5.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.description,
  });

  List<Map<String, Object>> tovarMap() {
    return variation.map((e) {
      return {
        "_id": e.id,
        "type": e.type,
        "color": e.color,
        "price": e.price,
        "qty": e.qty
      };
    }).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'images': images.toList(),
      'variation': tovarMap(),
      'rating': rating,
      'isFavourite': isFavourite,
      'isPopular': isPopular,
      'title': title,
      'description': description
    };
  }

  Product.fromMap(Map<String, dynamic> map)
      : images = List<String>.from(map['images']),
        id = map['_id'],
        variation = (map['variation'] as List)
            .map((itemWord) => ProductVariation.fromMap(itemWord))
            .toList(),
        //List<ProductVariation>.from(map['variation'] as List<ProductVariation>),

        //

        rating = map['rating'],
        isFavourite = map['isFavourite'],
        isPopular = map['isPopular'],
        title = map['title'],
        description = map['description'];
}

class SuperProduct {
  Product prod;
  List<File> chacheFiles = <File>[];
  SuperProduct(this.prod, this.chacheFiles);
}

// Our demo Products
/*
List<ProductVariation> vari = [
  ProductVariation(
      id: M.ObjectId(), type: "L", color: "Red", price: 700.50, qty: 200),
];
*/
List<Product> demoProducts = [];
/*Product(
    id: M.ObjectId(),
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    variation: [
      ProductVariation(
          id: M.ObjectId(), type: "S", color: "Red", price: 700.50, qty: 200),
      ProductVariation(
          id: M.ObjectId(),
          type: "M",
          color: "Yellow",
          price: 800.50,
          qty: 400),
      ProductVariation(
          id: M.ObjectId(), type: "L", color: "Blue", price: 1300.50, qty: 100),
      ProductVariation(
          id: M.ObjectId(),
          type: "XL",
          color: "Black",
          price: 1990.50,
          qty: 160),
    ],
    title: "Pizza Tikka",
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: M.ObjectId(),
    images: [
      "assets/images/Image Popular Product 2.png",
    ],
    variation: [
      ProductVariation(
          id: M.ObjectId(), type: "S", color: "Red", price: 700.50, qty: 200),
      ProductVariation(
          id: M.ObjectId(),
          type: "M",
          color: "Yellow",
          price: 800.50,
          qty: 400),
      ProductVariation(
          id: M.ObjectId(), type: "L", color: "Blue", price: 1300.50, qty: 100),
      ProductVariation(
          id: M.ObjectId(),
          type: "XL",
          color: "Black",
          price: 1990.50,
          qty: 160),
    ],
    title: "Zinger Burger",
    description: "Tasty Zinger",
    rating: 4.3,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: M.ObjectId(),
    images: [
      "assets/images/glap.png",
    ],
    variation: [
      ProductVariation(
          id: M.ObjectId(), type: "S", color: "Red", price: 700.50, qty: 200),
      ProductVariation(
          id: M.ObjectId(),
          type: "M",
          color: "Yellow",
          price: 800.50,
          qty: 400),
      ProductVariation(
          id: M.ObjectId(), type: "L", color: "Blue", price: 1300.50, qty: 100),
      ProductVariation(
          id: M.ObjectId(),
          type: "XL",
          color: "Black",
          price: 1990.50,
          qty: 160),
    ],
    title: "Spicy Wings",
    description: "Tasty Wings",
    rating: 3.3,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: M.ObjectId(),
    images: [
      "assets/images/wireless headset.png",
    ],
    variation: [
      ProductVariation(
          id: M.ObjectId(), type: "S", color: "Red", price: 700.50, qty: 200),
      ProductVariation(
          id: M.ObjectId(),
          type: "M",
          color: "Yellow",
          price: 800.50,
          qty: 400),
      ProductVariation(
          id: M.ObjectId(), type: "L", color: "Blue", price: 1300.50, qty: 100),
      ProductVariation(
          id: M.ObjectId(),
          type: "XL",
          color: "Black",
          price: 1990.50,
          qty: 160),
    ],
    title: "Spicy Wings",
    description: "Tasty Wings",
    rating: 3.3,
    isFavourite: true,
    isPopular: true,
  ),
];
*/
const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";

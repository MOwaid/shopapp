import 'dart:collection';
import 'dart:core';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:mongo_dart/mongo_dart.dart';
import 'Cart.dart';
import 'ProductVariation.dart';

class Product {
  final ObjectId id;
  final String title, description;
  final String cat;
  final List<String> images;
  final List<ProductVariation> variation;
  final double rating;
  final bool isFavourite, isPopular, isOffer, isDeal, isAvailable;

  Product({
    required this.id,
    required this.images,
    required this.variation,
    this.rating = 5.0,
    this.isFavourite = false,
    this.isOffer = false,
    this.isDeal = false,
    this.isPopular = false,
    this.isAvailable = false,
    required this.cat,
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
      'isOffer': isOffer,
      'isDeal': isDeal,
      'isAvailable': isAvailable,
      'title': title,
      'description': description,
      'cat': cat
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
        isOffer = map['isOffer'],
        isDeal = map['isDeal'],
        rating = map['rating'],
        isFavourite = map['isFavourite'],
        isPopular = map['isPopular'],
        isAvailable = map['isAvailable'],
        title = map['title'],
        description = map['description'],
        cat = map['cat'];
}

class SuperProduct {
  Product prod;
  List<File> chacheFiles = <File>[];
  SuperProduct(this.prod, this.chacheFiles);
}

List<Product> demoProducts = [];

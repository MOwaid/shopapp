import 'package:mongo_dart/mongo_dart.dart';

class ProductVariation {
  final ObjectId id;
  final String type;
  final String color;
  final double price;
  final double qty;

  ProductVariation(
      {required this.id,
      required this.type,
      required this.color,
      required this.price,
      // ignore: non_constant_identifier_names
      required this.qty});

// Code
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'type': type,
      'color': color,
      'price': price,
      'qty': qty
    };
  }

  ProductVariation.fromMap(Map<String, dynamic> map)
      : type = map['type'],
        id = map['_id'],
        color = map['color'],
        price = map['price'],
        qty = map['qty'];
}

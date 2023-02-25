import 'package:flutter/material.dart';

import 'package:shopapp/screens/catlist/components/product_tile.dart';

import '../../../Models/Product.dart';

// ignore: must_be_immutable
class ProductList extends StatelessWidget {
  ProductList({
    Key? key,
    required this.products,
    required this.cat,
    this.pressOnSeeMore,
  }) : super(key: key);

  List<Product> products;
  final GestureTapCallback? pressOnSeeMore;
  String cat;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: products.length,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) => InkWell(
          onTap: () {},
          child: ProductTile(
            itemNo: index,
            product: products[index],
          ),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
      );
    });
  }
}

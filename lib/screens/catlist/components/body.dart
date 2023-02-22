import 'package:flutter/material.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/screens/catlist/components/product_list.dart';

import 'package:shopapp/utils/size_config.dart';

import '../../../Models/Product.dart';
import 'top_rounded_container.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  final String catagory;

  const Body({Key? key, required this.catagory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> filteredItems =
        demoProducts.where((element) => element.cat == catagory).toList();
    if (filteredItems.isEmpty) {
      return const Text("No product for sale at the moment!");
    }
    return ListView(
      children: [
        //ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductList(
                products: filteredItems,
                cat: catagory,
                pressOnSeeMore: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

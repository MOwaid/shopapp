import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Models/Cart.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:shopapp/components/default_button.dart';

import 'package:shopapp/utils/size_config.dart';

import '../../../Models/Product.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final SuperProduct product;

  Body({Key? key, required this.product}) : super(key: key);
  String variation = "";
  int itemquantity = 1;
  double itemtotalcost = 0;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product.prod,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: const Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    ProductVar(product: product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: DefaultButton(
                          text: "Add To Cart",
                          press: () {
                            item.productId = product.prod.id;
                            item.productName = product.prod.title;
                            item.initialPrice = product.prod.variation[0].price;
                            item.image = product.prod.images[0];

                            Cartitem newitem = Cartitem(
                                id: M.ObjectId(),
                                productId: item.productId,
                                productName: item.productName,
                                productExtra: item.productExtra,
                                initialPrice: item.initialPrice,
                                productPrice: item.productPrice,
                                quantity: item.quantity,
                                image: item.image);
                            Provider.of<CartOne>(context, listen: false)
                                .items
                                .add(newitem);
                            Provider.of<CartOne>(context, listen: false)
                                .itemAdd();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

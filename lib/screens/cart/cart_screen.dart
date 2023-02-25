import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/Cart.dart';
import '../../Models/Product.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: const Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(children: [
            const SizedBox(
              width: 50,
              child: Text(
                "Cart -",
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 88,
              child: Text(
                "${Provider.of<CartOne>(context, listen: true).items.length} items",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          ]),
          const SizedBox(height: 7),
          Row(children: const [
            Icon(
              Icons.swipe_left,
              size: 20.0,
              color: Colors.white,
            ),
            SizedBox(
              width: 200,
              child: Text(
                "   Swipe left to remove items",
                style: TextStyle(color: Colors.yellow, fontSize: 14),
              ),
            )
          ]),
        ],
      ),
    );
  }
}

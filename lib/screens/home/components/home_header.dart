import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/screens/cart/cart_screen.dart';

import '../../../Models/Cart.dart';

import '../../../utils/size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SearchField(),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            press: () => Navigator.pushNamed(context, CartScreen.routeName),
            // ignore: avoid_print
            numOfitem: Provider.of<CartOne>(context, listen: true)
                .items
                .length, // userCart.items.length,
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfitem: 0,
            press: () {},
          ),
        ],
      ),
    );
  }
}

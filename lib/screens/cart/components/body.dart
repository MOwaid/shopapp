import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../Models/Cart.dart';
import '../../../Models/Product.dart';
import '../../../utils/size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: Provider.of<CartOne>(context, listen: true).items.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(Provider.of<CartOne>(context, listen: true)
                .items[index]
                .productId
                .toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                Provider.of<CartOne>(context, listen: false)
                    .items
                    .removeAt(index);
                Provider.of<CartOne>(context, listen: false).itemCountChange();
              });
            },
            background: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: CartCard(
                cart:
                    Provider.of<CartOne>(context, listen: false).items[index]),
          ),
        ),
      ),
    );
  }
}

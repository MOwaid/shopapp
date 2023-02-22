import 'package:flutter/material.dart';
import 'package:shopapp/Models/ProductVariation.dart';
import 'package:shopapp/components/rounded_icon_btn.dart';

import '../../../Models/Cart.dart';
import '../../../Models/Product.dart';
import '../../../utils/Constants.dart';

import '../../../utils/size_config.dart';

class ProductVar extends StatefulWidget {
  const ProductVar({
    Key? key,
    required this.product,
  }) : super(key: key);

  final SuperProduct product;

  @override
  _ProductVarState createState() => _ProductVarState();
}

class _ProductVarState extends State<ProductVar> {
  @override
  void initState() {
    super.initState();
    item.quantity = 1;
    selectedValue = widget.product.prod.variation[0];
    item.productExtra = selectedValue.type;
    item.productPrice = selectedValue.price;
  }

  late ProductVariation selectedValue;

  List<DropdownMenuItem<ProductVariation>> dropDown() {
    List<DropdownMenuItem<ProductVariation>> dropDownItems = [];

    for (int i = 0; i < widget.product.prod.variation.length; i++) {
      //for every currency in the list we create a new dropdownmenu item

      //String price = pv.price.toString();
      var newItem = DropdownMenuItem(
        value: widget.product.prod.variation[i],
        child: Text(widget.product.prod.variation[i].type),
      );
      // add to the list of menu item
      dropDownItems.add(newItem);
    }

    return dropDownItems;
  }

  loadVeration() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),

      // dropdown below..
      child: DropdownButton<ProductVariation>(
        items: dropDown(),
        onChanged: (value) => {
          setState(() => selectedValue = value!),
          item.productExtra = selectedValue.type,
          item.productPrice = selectedValue.price
        },
        value: selectedValue,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 42,
        underline: const SizedBox(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo

    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          children: [
            Row(
              children: [
                loadVeration(),
                const Spacer(),
                RoundedIconBtn(
                  icon: Icons.remove,
                  press: () {
                    if (item.quantity > 1) {
                      setState(() => item.quantity--);
                    }
                  },
                ),
                SizedBox(width: getProportionateScreenWidth(10)),
                Text(item.quantity.toString(), style: headingStyle1),
                SizedBox(width: getProportionateScreenWidth(10)),
                RoundedIconBtn(
                  icon: Icons.add,
                  showShadow: true,
                  press: () {
                    setState(() => item.quantity++);
                  },
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Row(
              children: [
                Text(
                    "Total Price:  ${(item.productPrice * item.quantity).toString()}/-",
                    style: headingStyle1),
                const Spacer(),
              ],
            ),
          ],
        ));
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border:
            Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

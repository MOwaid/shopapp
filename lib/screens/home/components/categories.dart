import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/size_config.dart';
import '../../catlist/catlist_screen.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/pizzasmall.svg", "text": "Pizza's"},
      {"icon": "assets/icons/burger.svg", "text": "Burger's"},
      {"icon": "assets/icons/fries.svg", "text": "Fries"},
      {"icon": "assets/icons/wings.svg", "text": "Wings"},
      {"icon": "assets/icons/shots.svg", "text": "HotShots"},
      {"icon": "assets/icons/paratha.svg", "text": "Paratha's"},
      {"icon": "assets/icons/platter.svg", "text": "Platter"},
      {"icon": "assets/icons/soda.svg", "text": "Drinks"},
    ];

    return Padding(
      padding: EdgeInsets.only(
          left: getProportionateScreenWidth(20),
          right: getProportionateScreenWidth(20)),
      child: Column(children: [
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              ...List.generate(
                categories.length,
                (index) => CategoryCard(
                  icon: categories[index]["icon"],
                  text: categories[index]["text"],
                  press: () {},
                ),
              )
            ])),
      ]),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(65),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              CatlistScreen.routeName,
              arguments: CatDetailsArguments(catname: text!),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(7)),
                  height: getProportionateScreenWidth(55),
                  width: getProportionateScreenWidth(55),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFECDF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(icon!),
                ),
                const SizedBox(height: 5),
                Text(text!, textAlign: TextAlign.center)
              ],
            ),
          ),
        ));
  }
}

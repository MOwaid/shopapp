import 'package:flutter/material.dart';
import 'package:shopapp/components/default_button.dart';

import 'package:shopapp/utils/size_config.dart';

import '../../../Models/Settings.dart';
import '../../home/home_screen.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final PageArguments agrs =
        ModalRoute.of(context)!.settings.arguments as PageArguments;

    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight * 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        Text(
          agrs.message,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        Text(
          "Thank you for your order. Your order will \nbe ready shortly. Please goto the orders \ntab to track the status of your order.",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(14),
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: agrs.buttonlabel,
            press: () {
              if (agrs.perviousPagename == "OrderComplete") {
                Navigator.pushNamed(context, HomeScreen.routeName);
              } else {}
            },
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

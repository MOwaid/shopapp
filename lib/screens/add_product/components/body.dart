import 'package:flutter/material.dart';
import 'package:shopapp/utils/size_config.dart';

import '../../../utils/Constants.dart';
import 'add_product_form.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                /*   Text("Add New Product", style: headingStyle),
               const Text(
                  style: TextStyle(
                    fontSize: 12,
                    shadows: [
                      Shadow(
                          color: Color.fromARGB(255, 69, 91, 212),
                          offset: Offset(0, -5))
                    ],
                    color: Colors.transparent,
                    decorationColor: Colors.blue,
                    decorationThickness: 2,
                  ),
                  "Add new product to your Shop",
                  textAlign: TextAlign.center,
                ), SizedBox(height: SizeConfig.screenHeight * 0.01),*/

                const AddProductForm(),
                SizedBox(height: getProportionateScreenHeight(5)),
                Text(
                  "By continuing your confirm that you agree \nwith our Term and Condition",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

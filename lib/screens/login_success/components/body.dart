import 'package:flutter/material.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/screens/home/home_screen.dart';
import 'package:shopapp/screens/profile/profile_screen.dart';
import 'package:shopapp/utils/size_config.dart';

import '../../../Models/Settings.dart';
import '../../sign_in/sign_in_screen.dart';

class Body extends StatelessWidget {
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
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          agrs.message,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: agrs.buttonlabel,
            press: () {
              if (agrs.perviousPagename == "update") {
                Navigator.pushNamed(context, ProfileScreen.routeName);
              } else {
                MaterialPageRoute(builder: (context) => const SignInScreen());
              }
            },
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

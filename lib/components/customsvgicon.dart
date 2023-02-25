import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/size_config.dart';

class CustomSvgIcon extends StatelessWidget {
  const CustomSvgIcon({
    Key? key,
    required this.svgIcon,
  }) : super(key: key);

  final String svgIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenWidth(1),
        getProportionateScreenWidth(1),
        getProportionateScreenWidth(1),
      ),
      child: SvgPicture.asset(
        svgIcon,
        height: getProportionateScreenWidth(25),
      ),
    );
  }
}

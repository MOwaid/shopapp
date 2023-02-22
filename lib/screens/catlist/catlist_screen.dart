import 'package:flutter/material.dart';

import '../../Models/Product.dart';

import 'components/body.dart';
import 'components/custom_app_bar.dart';

class CatlistScreen extends StatelessWidget {
  static String routeName = "/catlist";

  const CatlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CatDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as CatDetailsArguments;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(catagory: agrs.catname),
      ),
      body: Body(catagory: agrs.catname),
    );
  }
}

class CatDetailsArguments {
  final String catname;

  CatDetailsArguments({required this.catname});
}

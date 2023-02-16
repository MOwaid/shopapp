import 'package:flutter/material.dart';

import 'components/body.dart';

class ProdSuccessScreen extends StatelessWidget {
  static String routeName = "/prod_success";

  const ProdSuccessScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: const Text("Product Added"),
      ),
      body: const Body(),
    );
  }
}

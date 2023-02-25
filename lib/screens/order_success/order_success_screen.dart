import 'package:flutter/material.dart';

import 'components/body.dart';

class OrderSuccessScreen extends StatelessWidget {
  static String routeName = "/order_success";

  const OrderSuccessScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("Successfull"),
      ),
      body: Body(),
    );
  }
}

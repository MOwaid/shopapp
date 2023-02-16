import 'package:flutter/material.dart';

import '../../components/coustom_bottom_nav_bar.dart';
import '../../utils/enums.dart';
import 'components/body.dart';

class AddProductScreen extends StatelessWidget {
  static String routeName = "/add_product";

  const AddProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: const Body(),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
  }
}

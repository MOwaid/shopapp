import 'package:flutter/material.dart';
import 'package:shopapp/components/coustom_bottom_nav_bar.dart';
import 'package:shopapp/utils/enums.dart';

import '../../Models/DBHelper.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Back ${DBHelper.currentUser.name.toUpperCase()}'),
      ),
      body: Body(),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}

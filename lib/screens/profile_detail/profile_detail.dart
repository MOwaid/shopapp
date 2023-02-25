import 'package:flutter/material.dart';

import 'components/body.dart';

class ProfileDetailScreen extends StatelessWidget {
  static String routeName = "/profile_detail";

  const ProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Profile"),
      ),
      body: Body(),
    );
  }
}

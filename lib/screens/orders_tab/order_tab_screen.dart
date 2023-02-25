import 'package:flutter/material.dart';

import '../../Models/DBHelper.dart';
import '../../Models/currentUser.dart';
import 'components/allOrders.dart';
import 'components/closedOrders.dart';
import 'components/openOrders.dart';

class OrdertabScreen extends StatefulWidget {
  const OrdertabScreen({super.key});
  static String routeName = "/order_tab";

  @override
  // ignore: no_logic_in_create_state
  _OrdertabScreenState createState() => _OrdertabScreenState();
}

class _OrdertabScreenState extends State<OrdertabScreen> {
  _OrdertabScreenState();

  Future<void> getOrders() async {
    await DBHelper.getuserOrders(CurrentUser.userID!);
  }

  @override
  Widget build(BuildContext context) {
    getOrders();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            indicatorColor: Colors.amberAccent,
            indicatorWeight: 6,
            //isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.track_changes), text: "Orders"),
              Tab(icon: Icon(Icons.history), text: "History"),
              Tab(icon: Icon(Icons.all_inclusive_outlined), text: "All Orders"),
            ],
          ),
          title: const Text('Orders History'),
        ),
        body: const TabBarView(
          children: [
            OpenOrder(),
            CloseOrders(),
            AllOrders(),
          ],
        ),
      ),
    );
  }
}

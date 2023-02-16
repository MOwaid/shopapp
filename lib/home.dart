import 'package:flutter/material.dart';
import 'package:shopapp/widgets/navdrawer.dart';

import 'Pages/CartPage.dart';
import 'Pages/HomePage.dart';
import 'Pages/SearchPage.dart';
//import 'package:shopping_cart/pages/HomePage.dart';
//import 'package:shopping_cart/pages/ProfilePage.dart';
//import 'package:shopping_cart/pages/ProfilePage1.dart';
//import 'package:shopping_cart/pages/SearchPage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedPosition = 0;
  List<Widget> listBottomWidget = [];

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    addHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        //    future: DBHelper.getDocuments(),
        builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container(
          color: Colors.white,
          child: const LinearProgressIndicator(
            backgroundColor: Colors.black,
          ),
        );
      } else {
        if (snapshot.hasError) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Text(
                'Something went wrong, try again.',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: const Text("Pizza Adda"),
            ),
            drawer: const NavDrawer(),
            backgroundColor: Colors.grey.shade100,
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: "Search"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), label: "Cart"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Account"),
              ],
              currentIndex: selectedPosition,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.grey.shade100,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.black,
              onTap: (position) {
                setState(() {
                  selectedPosition = position;
                });
              },
            ),
            body: Builder(builder: (context) {
              return listBottomWidget[selectedPosition];
            }),
          );
        }
      }
    });
  }

  void addHomePage() {
    listBottomWidget.add(const HomePage());
    listBottomWidget.add(const SearchPage());
    listBottomWidget.add(const CartPage());
    listBottomWidget.add(const CartPage());
    //  listBottomWidget.add(ProfilePage1());
  }
}

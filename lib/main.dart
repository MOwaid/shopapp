import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp/Models/Cart.dart';
import 'package:shopapp/Models/DBHelper.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/routes.dart';
import 'package:shopapp/screens/splash/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:mongo_dart/mongo_dart.dart' as M;

import 'Models/currentUser.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String Error = "No";
  // Initialize a new Firebase App instance
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    Error = "firebase connection failed";
  }
  try {
    await DBHelper.connect();
    await DBHelper.getproductCollections();
  } catch (e) {
    Error = "Database connection failed!";
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();

  CurrentUser.setuserID = prefs.getString("userID");

  runApp(
    ChangeNotifierProvider(
      create: (_) => CartOne(
          id: M.ObjectId(),
          totalQuantity: 0,
          totalPrice: 0.00,
          items: [],
          vat: 0.00,
          posCharges: 0.00,
          orderdate: DateTime.now(),
          userID: DBHelper.currentUser.userID,
          username: DBHelper.currentUser.name,
          userAddress: DBHelper.currentUser.address.streetline1,
          Alatitude: DBHelper.currentUser.address.latitude,
          Alongitude: DBHelper.currentUser.address.longitude,
          orderStatus: 1,
          riderID: "1",
          managerID: "1",
          note: "No comments"),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza Shop',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(title: 'Pizzadda Home Page'),
      debugShowCheckedModeBanner: false,

      home: const SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final GlobalKey<ScaffoldState> _key = GlobalKey();

  List<Map<String, dynamic>> data = [];

  navigatePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const Login();
        },
        /* settings: RouteSettings(
          arguments: data,
        ),*/
      ),
    ).then((value) => setState(() {}));

    //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Login()));
  }

  splashMove() {
    return Timer(const Duration(seconds: 4), navigatePage);
  }

  @override
  void initState() {
    super.initState();
    splashMove();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    if (Error != "No") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(Error as String)));
      exit(0);
    }

    return FutureBuilder(
        future: DBHelper.getDocuments(),
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
              data = snapshot.data!;
              return Scaffold(
                // drawer: const NavDrawer(),
                appBar: AppBar(
                  // Here we take the value from the MyHomePage object that was created by
                  // the App.build method, and use it to set our appbar title.
                  title: Text(widget.title),
                ),
                body: Container(
                    color: Colors.white,
                    child: const Center(
                      child: Image(
                        image: AssetImage("assets/images/ic_logo.png"),
                        height: 140,
                        width: 140,
                      ),
                    )),
              );
            }
          }
        });
  }
}*/

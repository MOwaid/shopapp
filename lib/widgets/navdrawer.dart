import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
    child: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
      const UserAccountsDrawerHeader( // <-- SEE HERE
      decoration: BoxDecoration(color: Color(0xff764abc)),
    accountName: Text("Abdual Mateen",
    style: TextStyle(
    fontWeight: FontWeight.bold,
    ),
    ),
    accountEmail: Text(
    "abdul.Mateen@gmail.com",
    style: TextStyle(
    fontWeight: FontWeight.bold,
    ),
    ),
    currentAccountPicture: FlutterLogo(),
    ),
          ListTile(
            leading: const Icon(Icons.input),
            title: const Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.verified_user),
            title: const Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.border_color),
            title: const Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),

          const AboutListTile( // <-- SEE HERE
            icon: Icon(
              Icons.info,
            ),
            applicationIcon: Icon(
              Icons.local_play,
            ),
            applicationName: 'Pizza Shop App',
            applicationVersion: '1.0.05',
            applicationLegalese: '©2023 Pizzadda',
            aboutBoxChildren: [
              ///Content goes here...
            ],
            child: Text('About app'),
          ),

        ],
      ),
    ),
    );
  }
}
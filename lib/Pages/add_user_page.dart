import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:shopapp/Models/Address.dart';
import 'package:shopapp/Models/DBHelper.dart';

import '../Models/User.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    ageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /* final User user = ModalRoute.of(context).settings.arguments;
    var widgetText = 'Add User';
    if (user != null) {
      nameController.text = user.name;
      phoneController.text = user.phone.toString();
      ageController.text = user.age.toString();
      widgetText = 'Update User';
    }*/
    DBHelper.connect();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    decoration: const InputDecoration(labelText: 'Phone'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: ageController,
                    decoration: const InputDecoration(labelText: 'Age'),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 4.0),
              child: ElevatedButton(
                child: const Text("Add User"),
                onPressed: () {
                  /* if (user != null) {
                    updateUser(user);
                  } else {*/
                  insertUser();
                  //   }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  insertUser() async {
    final Address adr = Address(
        id: M.ObjectId(),
        houseNo: '76',
        streetline1: 'Gulshan-e-Hadeed',
        city: 'Karachi',
        state: 'Sindh',
        country: 'Pakistan');

    final User user = User(
        id: M.ObjectId(),
        userID: 'MOWAID',
        name: nameController.text,
        password: phoneController.text,
        passhint: 'My city name',
        address: adr,
        email: 'm_owaid@hotmail.com',
        dob: '15-03-1978',
        mobileno1: '03343441685',
        mobileno2: '00923343441685');
    await DBHelper.insert(user);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  updateUser(User user) async {
    print('updating: ${nameController.text}');
    final adr = Address(
        id: M.ObjectId(),
        houseNo: '76',
        streetline1: 'Gulshan-e-Hadeed',
        city: 'Karachi',
        state: 'Sindh',
        country: 'Pakistan');
    final updateuser = User(
        id: M.ObjectId(),
        userID: 'MOWAID',
        name: nameController.text,
        password: phoneController.text,
        passhint: 'My city name',
        address: adr,
        email: 'm_owaid@hotmail.com',
        dob: '15-03-1978',
        mobileno1: '03343441685',
        mobileno2: '00923343441685');
    await DBHelper.update(updateuser);
    Navigator.pop(context);
  }
}

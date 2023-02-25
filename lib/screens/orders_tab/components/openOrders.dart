import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../Models/Cart.dart';
import '../../../utils/size_config.dart';
import 'order_card.dart';

class OpenOrder extends StatefulWidget {
  const OpenOrder({super.key});

  @override
  // ignore: no_logic_in_create_state
  _OpenOrderState createState() => _OpenOrderState();
}

class _OpenOrderState extends State<OpenOrder> {
  _OpenOrderState();
/*
  String profilename = "Profile.png";
  String imageUrl = "";

  @override
  void initState() {
    super.initState();
    tempProfileImage(profilename);
  }

  ImageProvider<Object> makeimage() {
    if (imageUrl == "") {
      return const AssetImage("assets/images/Profile Image.png");
    } else {
      return FileImage(File(imageUrl));
    }
  }

  tempProfileImage(String imagename) async {
    final Directory temp = await getTemporaryDirectory();
    final File imageFile = File('${temp.path}/$imagename');

    if (await imageFile.exists()) {
      setState(() {
        imageUrl = '${temp.path}/$imagename';
      });
    } else {}
  }

  Future<void> chooseImage(inputSource) async {
    final picker = ImagePicker();

    try {
      final pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

// using your method of getting an image
      final Directory temp = await getTemporaryDirectory();

// getting a directory path for saving
      final String path = temp.path;

// copy the file to a new path
      pickedImage?.saveTo('$path/Profile.png');

      setState(() {
        imageUrl = pickedImage!.path;
      });
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: useropenorders.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(useropenorders[index].id.toString()),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(
                            "Are you sure you want to delete ${userorders[index]}?"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              // TODO: Delete the item from DB etc..
                              setState(() {
                                useropenorders.removeAt(index);
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              } else {
                // TODO: Navigate to edit page;
              }
            },

            // direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {});
            },
            background: slideRightBackground(),
            secondaryBackground: slideLeftBackground(),
            child: OrderCard(cart: useropenorders[index]),
          ),
        ),
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE6E6),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.details,
              color: Colors.green,
            ),
            Text(
              " Details",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE6E6),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Spacer(),
          SvgPicture.asset("assets/icons/receipt.svg"),
        ],
      ),
    );

/*  return Container(
    color: Colors.red,
    child: Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const <Widget>[
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text(
            " Delete",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    ),
  );*/
  }
}

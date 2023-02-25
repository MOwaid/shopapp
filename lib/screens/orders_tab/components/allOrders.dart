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

class AllOrders extends StatefulWidget {
  const AllOrders({super.key});

  @override
  // ignore: no_logic_in_create_state
  _AllOrdersState createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  _AllOrdersState();

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
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: Provider.of<CartOne>(context, listen: true).items.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(Provider.of<CartOne>(context, listen: true)
                .items[index]
                .productId
                .toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                Provider.of<CartOne>(context, listen: false)
                    .items
                    .removeAt(index);
                Provider.of<CartOne>(context, listen: false).itemCountChange();
              });
            },
            background: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: OrderCard(cart: userorders[index]),
          ),
        ),
      ),
    );
  }
}

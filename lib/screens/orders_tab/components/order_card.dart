import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../Models/Cart.dart';
import 'package:flutter/material.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/customsvgicon.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class OrderCard extends StatefulWidget {
  final CartOne cart;

  const OrderCard({
    super.key,
    required this.cart,
  });

  @override
  // ignore: no_logic_in_create_state
  _OrderCard createState() => _OrderCard(cart: cart);
}

class _OrderCard extends State<OrderCard> {
  _OrderCard({
    required this.cart,
  });

  final CartOne cart;
/*
  final List<File> _imageFile = <File>[];

  @override
  void initState() {
    super.initState();

    /// xproduct = SuperProduct(product, _imageFile);
    loadImage(cart.image);
  }

  Future loadImage(String imagename) async {
    final Directory temp = await getTemporaryDirectory();
    final File imageFile = File('${temp.path}/images/$imagename');

    if (await imageFile.exists()) {
      setState(() {
        _imageFile.add(imageFile);
      });
    } else {
      // Image doesn't exist in cache
      await imageFile.create(recursive: true);
      final firefile = FirebaseStorage.instance.ref().child(imagename);
// no need of the file extension, the name will do fine.
      final downloadTask = firefile.writeToFile(imageFile);
      downloadTask.snapshotEvents.listen((taskSnapshot) {
        switch (taskSnapshot.state) {
          case TaskState.running:
            // TODO: Handle this case.
            break;
          case TaskState.paused:
            // TODO: Handle this case.
            break;
          case TaskState.success:
            break;
          case TaskState.canceled:
            // TODO: Handle this case.
            break;
          case TaskState.error:
            // TODO: Handle this case.
            break;
        }
      });

      setState(() {
        _imageFile.add(imageFile);
      });
    }
  }

  Widget imageloading() {
    if (_imageFile.isEmpty) {
      return const CircularProgressIndicator();
    } else {
      return Image.file(_imageFile[0]);
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 68,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const CustomSvgIcon(
                  svgIcon:
                      "assets/icons/pizzadone.svg"), // Image.asset('assets/images/ic_logo.png'), //imageloading(),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.items[0].productName,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            const SizedBox(height: 2),
            Text(
              "+ ${cart.totalQuantity - 1} items",
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
            const SizedBox(height: 7),
            Row(children: [
              Text.rich(
                TextSpan(
                  text: "Rs:${cart.totalPrice}/-",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                  children: [
                    TextSpan(
                        text: orderStatus(cart.orderStatus),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.blue)),
                  ],
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(45)),
            ])
          ],
        )
      ],
    );
  }

  String orderStatus(int value) {
    if (value == 1) {
      return "  Status: [ Prepairing ]";
    }
    if (value == 2) {
      return "  Status: [ Ready ]";
    }
    if (value == 3) {
      return "  Status: [ On Delivery ]";
    }
    if (value == 4) {
      return "  Status: [ Delivered ]";
    }
    return "Waiting";
  }
}

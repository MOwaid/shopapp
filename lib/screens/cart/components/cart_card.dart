import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../Models/Cart.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class CartCard extends StatefulWidget {
  final Cartitem cart;

  const CartCard({
    super.key,
    required this.cart,
  });

  @override
  // ignore: no_logic_in_create_state
  _CartCard createState() => _CartCard(cart: cart);
}

class _CartCard extends State<CartCard> {
  _CartCard({
    required this.cart,
  });

  final Cartitem cart;

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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: imageloading(),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.productName,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            const SizedBox(height: 2),
            Text(
              cart.productExtra,
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
            const SizedBox(height: 7),
            Row(children: [
              Text.rich(
                TextSpan(
                  text: "Rs:${cart.productPrice}/-",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                  children: [],
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(45)),
              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 6),
                        blurRadius: 10,
                        color: const Color(0xFFB0B0B0).withOpacity(0.2),
                      ),
                    ],
                  ),
                  child: Material(
                    type: MaterialType.transparency,
                    child: Ink(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 3.0),
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(2.0),
                        onTap: () {
                          if (cart.quantity > 1) {
                            setState(() => cart.quantity--);
                            Provider.of<CartOne>(context, listen: false)
                                .itemCountChange();
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Icon(
                            Icons.remove,
                            size: 15.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )),
              SizedBox(width: getProportionateScreenWidth(5)),
              Text(" ${cart.quantity}",
                  style: Theme.of(context).textTheme.bodyText1),
              SizedBox(width: getProportionateScreenWidth(10)),
              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 6),
                        blurRadius: 10,
                        color: const Color(0xFFB0B0B0).withOpacity(0.2),
                      ),
                    ],
                  ),
                  child: Material(
                    type: MaterialType.transparency,
                    child: Ink(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 3.0),
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(2.0),
                        onTap: () {
                          setState(() => cart.quantity++);
                          Provider.of<CartOne>(context, listen: false)
                              .itemCountChange();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Icon(
                            Icons.add,
                            size: 15.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )),
            ])
          ],
        )
      ],
    );
  }
}

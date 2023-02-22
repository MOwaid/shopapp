import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:path_provider/path_provider.dart';

import '../../../Models/Product.dart';
import '../../../utils/Constants.dart';
import '../../../utils/size_config.dart';
import '../../details/details_screen.dart';

class ProductTile extends StatefulWidget {
  final Product product;

  final int itemNo;
  const ProductTile({super.key, required this.product, required this.itemNo});

  @override
  // ignore: no_logic_in_create_state
  _ProductTile createState() => _ProductTile(itemNo: itemNo, product: product);
}

class _ProductTile extends State<ProductTile> {
  final int itemNo;
  final Product product;

  _ProductTile({this.itemNo = 0, required this.product});

  SuperProduct? xproduct;
  final List<File> _imageFile = [];

  @override
  void initState() {
    super.initState();
    xproduct = SuperProduct(product, _imageFile);
    loadImage(product.images[0], 0);
  }

  Future loadImage(String imagename, int fileindex) async {
    final Directory temp = await getTemporaryDirectory();
    final File imageFile = File('${temp.path}/images/$imagename');

    if (await imageFile.exists()) {
      setState(() {
        xproduct!.chacheFiles.add(imageFile);
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
        xproduct!.chacheFiles.add(imageFile);
      });
    }
  }

  Widget imageloading() {
    if (xproduct!.chacheFiles.isEmpty) {
      return const CircularProgressIndicator(strokeWidth: 2);
    } else {
      return Image.file(xproduct!.chacheFiles[0],
          width: 100, height: 122, fit: BoxFit.cover);
    }
  }

  @override
  Widget build(BuildContext context) {
    /* final Color color = Colors.primaries[itemNo % Colors.primaries.length];
    var cartList = BlocProvider.of<CartBloc>(context).items;*/

    ContainerTransitionType _transitionType = ContainerTransitionType.fade;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            arguments: ProductDetailsArguments(product: xproduct!),
          );
        },
        child: Container(
          //width: MediaQuery.of(context).size.width * 0.45,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6F9),
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x3600000F),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        child: imageloading(),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12, 4, 0, 0),
                        child: Text(
                          product.title,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12, 4, 0, 0),
                        child: Text('Rs:${product.variation[0].price}/-',
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(14),
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

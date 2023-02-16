import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopapp/screens/details/details_screen.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/constants.dart';
import '../utils/size_config.dart';
import '../Models/Product.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  // ignore: no_logic_in_create_state
  _ProductCard createState() => _ProductCard(product: this.product);
}

class _ProductCard extends State<ProductCard> {
  _ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
  });

  final double width, aspectRetio;
  final Product product;
  final List<File> _imageFile = <File>[];
  SuperProduct? xproduct;

  @override
  void initState() {
    super.initState();
  }

  loadAllImages() async {
    for (var i = 0; i < product.images.length; i++) {
      await loadImage(product.images[i], i);
    }
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
    loadImage(product.images[0], 0);
    if (xproduct!.chacheFiles.isEmpty) {
      return const CircularProgressIndicator();
    } else {
      return Image.file(xproduct!.chacheFiles[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    xproduct = SuperProduct(product, _imageFile);
    loadAllImages();

    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            arguments: ProductDetailsArguments(product: xproduct!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: (product.id.toString()),
                    child:
                        imageloading(), //,Image.file(loadImage(product.images[0])),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.title,
                style: const TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${product.variation[0].price}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      height: getProportionateScreenWidth(28),
                      width: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(
                        color: product.isFavourite
                            ? kPrimaryColor.withOpacity(0.15)
                            : kSecondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        // ignore: deprecated_member_use
                        color: product.isFavourite
                            ? const Color(0xFFFF4848)
                            : const Color(0xFFDBDEE4),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

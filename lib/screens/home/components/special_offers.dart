import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../../Models/Product.dart';
import '../../../utils/size_config.dart';
import '../../details/details_screen.dart';
import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> filteredItems = demoProducts
        .where((element) => element.cat == "Offers" || element.cat == "Deals")
        .toList();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenWidth(10)),
          child: SectionTitle(
            title: "Special Offers",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(0)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                filteredItems.length,
                (index) {
                  if (filteredItems[index].isOffer) {
                    return SpecialOfferCard(
                      category: filteredItems[index].title,
                      product: filteredItems[index],
                      numOfBrands: 1,
                      press: () {},
                    );
                  }
                  if (filteredItems[index].isDeal) {
                    return SpecialOfferCard(
                      category: filteredItems[index].title,
                      product: filteredItems[index],
                      numOfBrands: 1,
                      press: () {},
                    );
                  }

                  return const SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(10)),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatefulWidget {
  final Product product;
  final String category;
  final int numOfBrands;
  final GestureTapCallback press;

  const SpecialOfferCard(
      {super.key,
      required this.product,
      required this.category,
      required this.numOfBrands,
      required this.press});

  @override
  // ignore: no_logic_in_create_state
  _SpecialOfferCard createState() => _SpecialOfferCard(
      category: category,
      product: product,
      numOfBrands: numOfBrands,
      press: press);
}

class _SpecialOfferCard extends State<SpecialOfferCard> {
  _SpecialOfferCard({
    Key? key,
    required this.category,
    required this.numOfBrands,
    required this.product,
    required this.press,
  });

  final Product product;
  final List<File> _imageFile = <File>[];
  final String category;
  final int numOfBrands;
  final GestureTapCallback press;

  SuperProduct? xproduct;

  @override
  void initState() {
    super.initState();
    xproduct = SuperProduct(product, _imageFile);
    loadImage(product.images[0], 0);
  }

  /*loadAllImages() async {
    if (product.images.length > xproduct!.chacheFiles.length) {
      for (var i = 0; i < product.images.length; i++) {
        await loadImage(product.images[i], i);
      }
    } else {
      xproduct!.chacheFiles.clear();
      for (var i = 0; i < product.images.length; i++) {
        await loadImage(product.images[i], i);
      }
    }
  }
*/
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
      return const CircularProgressIndicator();
    } else {
      return Image.file(xproduct!.chacheFiles[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          arguments: ProductDetailsArguments(product: xproduct!),
        ),
        child: SizedBox(
          width: getProportionateScreenWidth(242),
          height: getProportionateScreenWidth(100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                imageloading(),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF343434).withOpacity(0.4),
                        const Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15.0),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "$numOfBrands offers")
                      ],
                    ),
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

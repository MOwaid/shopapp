import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../../Models/Product.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final SuperProduct product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  @override
  void initState() {
    super.initState();

    loadAllImages();
  }

  loadAllImages() async {
    if (widget.product.prod.images.length > widget.product.chacheFiles.length) {
      for (var i = 1; i < widget.product.prod.images.length; i++) {
        await loadImage(widget.product.prod.images[i], i);
      }
    } else {
      widget.product.chacheFiles.clear();
      for (var i = 0; i < widget.product.prod.images.length; i++) {
        await loadImage(widget.product.prod.images[i], i);
      }
    }
  }

  Future loadImage(String imagename, int fileindex) async {
    final Directory temp = await getTemporaryDirectory();
    final File imageFile = File('${temp.path}/images/$imagename');

    if (await imageFile.exists()) {
      setState(() {
        widget.product.chacheFiles.add(imageFile);
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
        widget.product.chacheFiles.add(imageFile);
      });
    }
  }

  Widget imageloading(int selected) {
    if (widget.product.chacheFiles.isEmpty) {
      return const CircularProgressIndicator();
    } else {
      return Image.file(widget.product.chacheFiles[selected]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(238),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.product.prod.id.toString(),
              child: //Image.file(widget.product.chacheFiles[selectedImage])
                  imageloading(
                      selectedImage), // Image.asset(widget.product.images[selectedImage]),
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.product.chacheFiles.length,
                (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.file(widget.product.chacheFiles[index]),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({super.key});

  @override
  // ignore: no_logic_in_create_state
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  _ProfilePicState();

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
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage:
                makeimage(), // AssetImage("assets/images/Profile Image.png"),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () {
                  chooseImage('gallery');
                },
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}

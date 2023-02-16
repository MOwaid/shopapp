import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

class FirebaseHelper {
  static FirebaseStorage storage = FirebaseStorage.instance;

  // Select and image from the gallery or take a picture with the camera
  // Then upload to Firebase Storage
  static Future<String> upload(String inputSource) async {
    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);

      try {
        // Uploading the selected image with some custom meta data
        var dowurl = await storage.ref(fileName).putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'uploaded_by': 'PizzaDDa',
              'description': 'Pizza shop Images'
            }));
        return dowurl.toString();
      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
          return "";
        }
      }
      return "";
    } catch (err) {
      if (kDebugMode) {
        print(err);
        return "";
      }
    }
    return "";
  }

  static Future<String> uploadfile(String inputSource) async {
    File imageFile = File(inputSource);
    final String fileName = path.basename(imageFile.path);

    try {
      // Uploading the selected image with some custom meta data
      await storage.ref(fileName).putFile(
          imageFile,
          SettableMetadata(customMetadata: {
            'uploaded_by': 'PizzaDDa',
            'description': 'Pizza shop Images'
          }));
      return fileName.toString();
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return "";
    }
  }

  /*Future<String> uploadImage(var imageFile) async {
    StorageReference ref = storage.ref().child("/photo.jpg");
    StorageUploadTask uploadTask = ref.putFile(imageFile);

    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    url = dowurl.toString();

    return url;
  }
*/
  // Retriew the uploaded images
  // This function is called when the app launches for the first time or when an image is uploaded or deleted
  static Future<List<Map<String, dynamic>>> loadImages() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
        "description":
            fileMeta.customMetadata?['description'] ?? 'No description'
      });
    });

    return files;
  }

  // Delete the selected image
  // This function is called when a trash icon is pressed
  Future<void> delete(String ref) async {
    await storage.ref(ref).delete();
    // Rebuild the UI
  }
}

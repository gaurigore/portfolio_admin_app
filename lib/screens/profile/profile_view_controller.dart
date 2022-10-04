import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:protfolio_admin_app/firebase/firebase_helper.dart';
import 'package:protfolio_admin_app/screens/profile/profile.dart';

class ProfileViewController extends GetxController {
  var selectedImagePath = ''.obs;
  var nameFlag = 0.obs;
  var cityFlag = 0.obs;
  var residenceFlag = 0.obs;
  var ageFlag = 0.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController residenceController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  late var imageUrl;

  void getImage(ImageSource imageSource) async {
    print("inside get image");
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      // selectedImagePath.value = pickedFile.path;

      //print("selected image=" + "${selectedImagePath}");
      Profile.image = File.fromUri(Uri.parse(pickedFile.path));
      //print(" image=${Profile.image}");
      await uploadImage();
    } else {
      Get.snackbar("error", "Image not Selected");
    }
  }

  Future<void> uploadImage() async {
    try {
      print("inside get upload");
      String filePath = basename(Profile.image.path);

      FirebaseHelper.firebaseStorageRef.child(filePath);
      UploadTask uploadTask = FirebaseHelper.firebaseStorageRef
          .child(filePath)
          .putFile(Profile.image);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() async => {
            imageUrl = await FirebaseHelper.firebaseStorageRef
                .child(filePath)
                .getDownloadURL(),

             await FirebaseHelper.profile
                .doc('TQo1UChTeqAtYShpAXhK')
                .update({"image": imageUrl}).then(
                    (value) => Get.snackbar("status", "image uploaded"))
          });
    } catch (e) {
      print(e);
    }
  }

  Future<void> editProfileData(String name, String city, String residence, String age) async {
    await
    FirebaseHelper.profile
        .doc('TQo1UChTeqAtYShpAXhK')
        .update({
      "name": name,
      "city":city,
      "residence":residence,
      "age":age

        }).then(
            (value) => Get.snackbar("status", "data Edited successfully"));


  }


}

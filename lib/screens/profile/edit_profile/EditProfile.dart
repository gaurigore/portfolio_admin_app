import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:protfolio_admin_app/firebase/firebase_helper.dart';
import 'package:protfolio_admin_app/screens/profile/profile.dart';
import 'package:protfolio_admin_app/screens/profile/profile_view_controller.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);


  static final profileController = Get.put(ProfileViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Stack(
                          children: [
                            Obx(
                                  () =>
                                  CircleAvatar(
                                    backgroundColor: Theme
                                        .of(context)
                                        .floatingActionButtonTheme
                                        .backgroundColor,
                                    radius: 70,
                                    backgroundImage: profileController
                                        .selectedImagePath.value ==
                                        ''
                                        ? const AssetImage(
                                        "assets/icons/profile.jpg")
                                        : NetworkImage(profileController.selectedImagePath.value)
                                    as ImageProvider,
                                  ),
                            ),
                            Positioned(
                                bottom: 0,
                                left: 75,
                                child: InkWell(
                                  onTap: () async {
                                    Get.bottomSheet(
                                      SizedBox(
                                        height:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.1,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(

                                                onPressed: () {
                                                  profileController.getImage(
                                                      ImageSource.camera);

                                                },
                                                icon: const Icon(
                                                  Icons.photo_camera,
                                                  size: 44,
                                                ),),
                                            IconButton(
                                                onPressed: () {
                                                  profileController.getImage(
                                                      ImageSource.gallery);
                                                },
                                                icon: const Icon(
                                                  Icons.image,
                                                  size: 44,
                                                )),
                                          ],
                                        ),
                                      ),
                                      backgroundColor:
                                      Theme
                                          .of(context)
                                          .primaryColor,
                                    );
                                  },
                                  child: const CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.blue,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: profileController.nameController,
                            decoration: InputDecoration(
                                label: const Text(
                                  "Name",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18))),
                          ),
                          SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.02),
                          TextField(
                            controller: profileController.cityController,
                            decoration: InputDecoration(
                                label: const Text(
                                  "City",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18))),

                            /*"Name",
                            style: TextStyle(
                              color: Colors.grey,
                            ),*/
                          ),
                          SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.02),
                          TextField(
                            controller: profileController.residenceController,
                            decoration: InputDecoration(
                                label: const Text(
                                  "Residence",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18))),
                          ),
                          SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.02),
                          TextField(
                            controller: profileController.ageController,
                            decoration: InputDecoration(
                                label: const Text(
                                  "Age",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18))),
                          ),
                          SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.02),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.05,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.3,
                            child: ElevatedButton(

                              onPressed: () {
                                profileController.editProfileData(
                                    profileController.nameController.text,
                                    profileController.cityController.text,
                                    profileController.residenceController.text,
                                    profileController.ageController.text);
                                Get.back();

                              },
                              child: const Text("Save"),

                            )),
                        SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.05,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.3,
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.back();

                                }, child: const Text("Cancel"))),
                      ],
                    )
                  ]),
                ),
      ),
    );

  }
}

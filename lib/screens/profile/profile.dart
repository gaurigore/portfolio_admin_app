import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:protfolio_admin_app/config/size_config.dart';
import 'package:protfolio_admin_app/firebase/firebase_helper.dart';
import 'package:protfolio_admin_app/screens/profile/edit_profile/EditProfile.dart';
import 'package:protfolio_admin_app/screens/profile/profile_view_controller.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  static final profileController = Get.put(ProfileViewController());

  static late File image;
  static String imageUrl = "";
  static final Stream<QuerySnapshot> _usersStream =
      FirebaseHelper.profile.snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              if (Get.isDarkMode) {
                Get.changeThemeMode(ThemeMode.light);
              } else {
                Get.changeThemeMode(ThemeMode.dark);
              }
            },
            icon: Icon(
              Icons.nightlight_round,
              color: Theme.of(context).iconTheme.color,
            ),
          )
        ],
        shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              print("inside  buider");
              WidgetsBinding.instance!.addPostFrameCallback((_) =>
                  profileController.selectedImagePath.value = data['image']);
              profileController.nameController.text = data['name'];
              profileController.cityController.text = data['city'];
              profileController.residenceController.text = data['residence'];
              profileController.ageController.text = data['age'];
              return Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Center(
                      child: Stack(
                        children: [
                          Obx(
                            () => CircleAvatar(

                              backgroundColor: Theme.of(context)
                                  .floatingActionButtonTheme
                                  .backgroundColor,
                              radius: 70,
                              backgroundImage: profileController
                                          .selectedImagePath.value ==
                                      ''
                                  ? const AssetImage("assets/icons/profile.jpg")
                                  : NetworkImage(data['image'])
                                      as ImageProvider,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Name",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              "${data['name']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.profilePageTextSize),
                            )),
                      ],
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).iconTheme.color,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "City",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: SizedBox(
                          child: Text(
                            data['city'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.profilePageTextSize),
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: Theme.of(context).iconTheme.color,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Residence",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          data['residence'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.profilePageTextSize),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: Theme.of(context).iconTheme.color,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Age",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          data['age'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.profilePageTextSize),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: Theme.of(context).iconTheme.color,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    height: 30,
                    decoration: const BoxDecoration(
                      border: Border(bottom:BorderSide(color: Colors.blue))
                    ),
                    child: TextButton(

                        onPressed: () {
                          Get.to(() => const EditProfile());
                        },
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(color: Colors.blue),
                        ),

                    ),
                  )
                ]),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

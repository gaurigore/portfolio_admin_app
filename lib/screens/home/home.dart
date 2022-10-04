import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:protfolio_admin_app/screens/bottom_navigation_bar/bottom_navigation_bar_controller.dart';
import 'package:protfolio_admin_app/screens/bottom_navigation_bar/bottom_navigation_bar_view.dart';

import 'package:protfolio_admin_app/screens/chat/chat_room.dart';
import 'package:protfolio_admin_app/screens/profile/profile.dart';
import 'package:protfolio_admin_app/screens/projects/projects_view.dart';
import 'package:protfolio_admin_app/screens/skills/skills_view.dart';



class Home extends StatelessWidget {
  final int selectedIndex = 0;

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).backgroundColor,

      body: Obx(() => IndexedStack(
            index: BottomNavigationBarController.selectedIndex.value,
            children: const [
              ChatRoom(),
              ProjectsView(),
              SkillsView(),
              Profile(),
            ],
          )),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child:const ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                  bottomLeft:  Radius.circular(12.0),
                  bottomRight:  Radius.circular(12.0),
                ),
                child: BottomNavigationBarView())),
      ),
    );
  }
}

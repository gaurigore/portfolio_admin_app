import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:protfolio_admin_app/screens/skills/add_skills/add_skills_view.dart';
import 'package:protfolio_admin_app/screens/skills/skills_view_controller.dart';

class SkillsView extends StatelessWidget {
  const SkillsView({Key? key}) : super(key: key);

  // static final skillandCodeController=Get.put(SkillsViewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text(
          "Skills",
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
        shape:  const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
      ),
      body: GetX<SkillsViewController>(
        init: Get.put(SkillsViewController()),
        builder: (SkillsViewController skillandCodeController) {
          return Padding(
            padding: const EdgeInsets.only(top:24,right: 12,left: 12),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 1.5),
              itemCount: skillandCodeController.skills.value.length,
              itemBuilder: (context, index) {
                return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularPercentIndicator(
                            percent: double.parse(skillandCodeController
                                .skills.value[index].percentage),
                            radius: 28,
                            lineWidth: 5.0,
                            backgroundColor: Colors.transparent,
                            center: Text(
                                "${(double.parse(skillandCodeController.skills.value[index].percentage) * 100).toStringAsFixed(0)} %"),
                            progressColor: Colors.amber,
                          ),
                        ),
                        Text(
                          skillandCodeController.skills.value[index].language,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Spacer()
                      ],
                    ));
              },
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          heroTag: "2",
          child: const Icon(Icons.add),
          onPressed: () {
            Get.bottomSheet(AddSkillsView());
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

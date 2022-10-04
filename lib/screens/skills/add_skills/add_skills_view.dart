import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protfolio_admin_app/model/skills_and_coding_model.dart';
import 'package:protfolio_admin_app/screens/skills/add_skills/add_skills_controller.dart';

class AddSkillsView extends StatelessWidget {
  const AddSkillsView({Key? key}) : super(key: key);
  static final TextEditingController languageNameController =
      TextEditingController();
  static final TextEditingController percentageController =
      TextEditingController();
  static final _skillController = Get.put(AddSkillsController());

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height * 02,
      color: Theme.of(context).backgroundColor,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("enter language name"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: languageNameController,
            decoration: InputDecoration(
                hintText: "language name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("enter language percentage"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: percentageController,
            decoration: InputDecoration(
              hintText: "percentage",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  final skillCodemodel = SkillsAndCodingModel(
                      language: languageNameController.text,
                      percentage: percentageController.text);
                  AddSkillsController.addSkills(
                      skillsAndCodingmodel: skillCodemodel);

                  Get.back(canPop: true);
                  languageNameController.clear();
                  percentageController.clear();
                },
                child: const Text(
                  "Add skills",
                  style: TextStyle(color: Colors.black),
                )),
          ),
        )
      ]),
    );
    ;
  }
}

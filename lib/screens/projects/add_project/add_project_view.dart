import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_projects_controller.dart';

class AddProjectView extends StatelessWidget {
  const AddProjectView({Key? key}) : super(key: key);
  static final TextEditingController projectNameController =
  TextEditingController();
  static final TextEditingController descriptionController =
  TextEditingController();
  static final _projectController=Get.put(AddProjectsController());

  @override
  Widget build(BuildContext context) {

    return Container(
      //height: MediaQuery.of(context).size.height * 02,
      color: Theme.of(context).backgroundColor,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("enter project name"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: projectNameController,
                decoration: InputDecoration(
                    hintText: "project name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("enter project description"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: "description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      _projectController.addProject(
                          projectNameController.text,
                          descriptionController.text);
                      Get.back(canPop: true);
                    projectNameController.clear();
                   descriptionController.clear();
                    },
                    child: const Text(
                      "Add Project",
                      style: TextStyle(color: Colors.black),
                    )),
              ),
            )
          ]),
    );
  }
}

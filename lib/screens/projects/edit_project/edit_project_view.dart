import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:protfolio_admin_app/screens/projects/edit_project/edit_project_Controller.dart';
class EditProjectView extends StatelessWidget {
  var docId;
  var name;
 var description;



 EditProjectView({required this.docId,required this.name,required this.description});

 static final TextEditingController projectNameController =
  TextEditingController();
  static final TextEditingController descriptionController =
  TextEditingController();


   final edit=Get.put(EditProjectController());
  @override
  Widget build(BuildContext context) {
    projectNameController.text=name;
    descriptionController.text=description;

    return  Container(
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
                      print("in calling update");
                      print(docId);
                      print(name);
                      print(description);

                      edit.editProject(documentId: docId,name: projectNameController.text,
                         description: descriptionController.text);
                      Get.back(canPop: true);
                    },
                    child: const Text(
                      "Edit Project",
                      style: TextStyle(color: Colors.black),
                    )),
              ),
            )
          ]),
    );
  }
}

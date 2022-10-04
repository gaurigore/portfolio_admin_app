import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protfolio_admin_app/screens/projects/delet_project/delete_project_controller.dart';

class DeleteProjectView extends StatelessWidget {
  static var docId;

  const DeleteProjectView({required docId});

  static final _deleteProjectController = Get.put(DeleteProjectController());

  @override
  Widget build(BuildContext context) {
    print("this is doc id");
    print(docId);
    return Row(
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
        IconButton(
            onPressed: () {
              _deleteProjectController.deleteProject(docmentID: docId);
            },
            icon: const Icon(Icons.delete)),
      ],
    );
  }
}

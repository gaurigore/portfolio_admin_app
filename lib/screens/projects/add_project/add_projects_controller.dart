import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

class AddProjectsController extends GetxController {
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference projects =
      FirebaseFirestore.instance.collection('projects');

  addProject(String projectName, String description) {
    return projects.add({
      'project_name': projectName,
      'description': description,
      'savedAt': DateTime.now(),
    });
    print("added successfully");
  }


}

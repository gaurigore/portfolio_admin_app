import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EditProjectController extends GetxController{
  CollectionReference projects = FirebaseFirestore.instance.collection('projects');

  Future<void> editProject({required documentId,required name,required description}) {
    print("in update");
    print(documentId);
    print(name);
    print(description);


    return projects
        .doc(documentId)
        .update({'project_name': name,
           'description':description})
        .then((value) => print("project Updated"))
        .catchError((error) => print("Failed to update project: $error"));
  }
}
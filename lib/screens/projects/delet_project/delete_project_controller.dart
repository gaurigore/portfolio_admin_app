import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DeleteProjectController extends GetxController{
  CollectionReference projects = FirebaseFirestore.instance.collection('projects');

  Future<void> deleteProject({docmentID}){
    print(docmentID);
  return projects
          .doc(docmentID)
          .delete()
          .then((value) => print("project Deleted"))
          .catchError((error) => print("Failed to delete project: $error"));

  }
}
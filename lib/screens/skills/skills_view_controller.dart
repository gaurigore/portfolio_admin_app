import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:protfolio_admin_app/firebase/firebase_helper.dart';
import 'package:protfolio_admin_app/model/skills_and_coding_model.dart';


class SkillsViewController extends GetxController{
  final Rx<List<SkillsAndCodingModel>> skills = Rx<List<SkillsAndCodingModel>>(
      []);

  static Stream<List<SkillsAndCodingModel>>  getData(){
    return FirebaseHelper.skills.snapshots().map((QuerySnapshot query){
      List<SkillsAndCodingModel> skills = [];
      for (var skill in query.docs) {
        final skillModel =
        SkillsAndCodingModel.fromDocumentSnapshot(documentSnapshot: skill);
        skills.add(skillModel);

      }
      return skills;
    });


  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    skills.bindStream(getData());
  }
}
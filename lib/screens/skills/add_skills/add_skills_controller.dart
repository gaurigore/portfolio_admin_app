

import 'package:get/get.dart';
import 'package:protfolio_admin_app/firebase/firebase_helper.dart';
import 'package:protfolio_admin_app/model/skills_and_coding_model.dart';


class AddSkillsController extends GetxController {



  static addSkills({required SkillsAndCodingModel skillsAndCodingmodel}) {
    FirebaseHelper.skills.add({
      'language': skillsAndCodingmodel.language,
      'percentage': skillsAndCodingmodel.percentage
    });
    print("skill Added");
  }




}

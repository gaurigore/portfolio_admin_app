

import 'package:cloud_firestore/cloud_firestore.dart';

class SkillsAndCodingModel{
  late String language;
  late String percentage;

  SkillsAndCodingModel({required this.language, required this.percentage});
  SkillsAndCodingModel.fromDocumentSnapshot({ required DocumentSnapshot documentSnapshot}){
    language=documentSnapshot['language'];
    percentage=documentSnapshot['percentage'];

  }

}
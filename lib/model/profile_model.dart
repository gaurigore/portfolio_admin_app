import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  String? profilePhoto;
  String? name;
  String? age;
  String? city;
  String? residence;

  ProfileModel(
      {required this.profilePhoto,
      required this.name,
      required this.age,
      required this.city,
      required this.residence});

  ProfileModel.fromMap(DocumentSnapshot snapshot){
    name=snapshot['name'];
    age=snapshot['age'];
    city=snapshot['city'];
    residence=snapshot['residence'];
    profilePhoto=snapshot['image'];


  }

}

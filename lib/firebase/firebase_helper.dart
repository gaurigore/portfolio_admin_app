import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:protfolio_admin_app/screens/home/home.dart';
import 'package:protfolio_admin_app/screens/profile/profile.dart';

class FirebaseHelper {
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static FirebaseStorage stoarage=FirebaseStorage.instance;
  static Reference firebaseStorageRef =stoarage.ref("profilePic");

  //for projectss
  static CollectionReference projects =
      FirebaseFirestore.instance.collection('projects');

  //for skills
  static CollectionReference skills = firebaseFirestore.collection('skills');

  static CollectionReference profile=firebaseFirestore.collection('Profile');
  static CollectionReference chats=firebaseFirestore.collection('chats');
  static CollectionReference admin=firebaseFirestore.collection('admin');


   static Future<void> createUserWithEmailAndPassword(String email,String password)async{
     try {
       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
           email: email,
           password: password,
       );
     } on FirebaseAuthException catch (e) {
       if (e.code == 'weak-password') {
         print('The password provided is too weak.');
       } else if (e.code == 'email-already-in-use') {
         print('The account already exists for that email.');
       }
     } catch (e) {
       print(e);
     }

   }
   static Future<void> signInWithEmailAndPassword(String email,String password)async{
     try {

       UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
           email: email,
           password: password);
       Get.offAll(const Home());
     } on FirebaseAuthException catch (e) {
       if (e.code == 'user-not-found') {
         print('No user found for that email.');
       } else if (e.code == 'wrong-password') {
         print('Wrong password provided for that user.');
       }
     }
   }
  static addMessage(String collectionName, String messages) async {
    CollectionReference result =
    chats.doc(collectionName).collection(collectionName);
    return result.add({'sender': 0, 'message': messages,
      'dateTime': DateTime.now()});
  }

  static Future<void> saveTokenToDatabase(String token) async {

    // Assume user is logged in for this example



    await FirebaseFirestore.instance
        .collection('admin')
        .doc('goregauri31@gmail.com')
        .update({
      'tokens': FieldValue.arrayUnion([token]),
    });
  }



}

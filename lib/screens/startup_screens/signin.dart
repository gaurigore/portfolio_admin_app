import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protfolio_admin_app/config/size_config.dart';
import 'package:protfolio_admin_app/firebase/firebase_helper.dart';
import 'package:protfolio_admin_app/screens/home/home.dart';

class SingIn extends StatelessWidget {
  const SingIn({Key? key}) : super(key: key);
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController =
      TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor: Colors.white,
      body: Column(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(top: 200, right: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Enter Email"),
                  SizeConfig.verticalSizedBox,
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                SizeConfig.inputTextBoxBorderRadius),
                            borderSide: const BorderSide(color: Colors.black))),
                  ),
                  SizeConfig.verticalSizedBox,
                  const Text("Enter Password"),
                  SizeConfig.verticalSizedBox,
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          SizeConfig.inputTextBoxBorderRadius),
                    )),
                  ),
                  SizeConfig.verticalSizedBox,
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.longButtonBorderRadius)))),
                      onPressed: () {
                        if(FirebaseAuth.instance.currentUser != null)
                        {
                          Get.offAll(const Home());
                        }
                        FirebaseHelper.signInWithEmailAndPassword(
                            emailController.text, passwordController.text);
                      },
                      child: const Text("Sing In"),
                    ),
                  ),
                  SizeConfig.verticalSizedBox,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

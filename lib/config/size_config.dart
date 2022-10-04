import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SizeConfig {
  static const double profilePageTextSize = 18;
  static const double inputTextBoxBorderRadius = 18;
  static Widget verticalSizedBox = SizedBox(
    height: MediaQuery.of(Get.context!).size.height * 0.02);
  static const double longButtonBorderRadius=12;
}

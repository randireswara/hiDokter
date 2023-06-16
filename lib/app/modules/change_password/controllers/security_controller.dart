import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SecurityController extends GetxController {
  //TODO: Implement SecurityController
  RxBool obscureText = true.obs;
  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController entryNewPass = TextEditingController();

  void showPassword() {
    obscureText.value = !obscureText.value;
    print(obscureText);
  }
}

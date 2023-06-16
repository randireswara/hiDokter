import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_dokter/app/database/authentication/authentication_repository.dart';
import 'package:hi_dokter/app/database/user_repo/check_user.dart';

import '../../../database/user_repo/user_repository.dart';

class LoginScreenController extends GetxController {
  //TODO: Implement LoginScreenController

  final checkUser = Get.put(CheckUser());

  final email = TextEditingController();
  final password = TextEditingController();
  RxBool loading = false.obs;

  final userRepo = Get.put(UserRepository());
  final autentikasi = Get.put(AuthenticationRepository());

  RxBool obscureText = true.obs;

  void loginWithEmail(String email, String password) async {
    loading.value = true;
    await autentikasi.loginWithEmailAndPassword(email, password);
    loading.value = false;
  }

  void showPassword() {
    obscureText.value = !obscureText.value;
    print(obscureText);
  }
}

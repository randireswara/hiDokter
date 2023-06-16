import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/user_model.dart';
import '../../../database/authentication/authentication_repository.dart';
import '../../../database/user_repo/user_repository.dart';

class SignInScreenController extends GetxController {
  //TODO: Implement SignInScreenController
  static SignInScreenController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullname = TextEditingController();
  final phoneNo = TextEditingController();
  final repassword = TextEditingController();
  final company = TextEditingController();
  final division = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool loading = true.obs;
  RxBool cek = false.obs;

  RxInt activeStepIndex = 0.obs;

  final userRepo = Get.put(UserRepository());
  RxBool obscureText = true.obs;

  void registerUser(UserModel user) async {
    loading.value = false;
    await userRepo.createUser(user);
    await AuthenticationRepository.instance
        .createUserWithEmailAndPassword(user.email!, user.password!);
    loading.value = true;
  }

  void phoneAuthentication(String phoneNo) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }

  void createUser(UserModel user) async {
    await userRepo.createUser(user);
    phoneAuthentication(user.phoneNo!);
  }

  void showPassword() {
    obscureText.value = !obscureText.value;
  }

  void next() {
    activeStepIndex.value += 1;
  }

  void onSubmit() {
    if (formKey.currentState!.validate()) {
      cek.value = true;
    }
  }
}

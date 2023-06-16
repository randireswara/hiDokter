import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';

import '../../../database/authentication/authentication_repository.dart';

class AccountSettingDrController extends GetxController {
  //TODO: Implement AccountSettingDrController

  late TextEditingController emailC;
  late TextEditingController nameC;
  late TextEditingController passwordC;
  late TextEditingController noHpC;
  late TextEditingController spesialis;
  late TextEditingController biografi;
  RxBool loading = false.obs;

  @override
  void onInit() {
    emailC = TextEditingController();
    nameC = TextEditingController();
    spesialis = TextEditingController();
    biografi = TextEditingController();
    passwordC = TextEditingController();
    noHpC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailC.dispose();
    nameC.dispose();
    spesialis.dispose();
    biografi.dispose();
    noHpC.dispose();
    passwordC.dispose();
    super.onClose();
  }

  void changeProfile(String name, String noHp, String spesialis,
      String biografi, String email) async {
    final authR = Get.put(AuthenticationRepository());
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    loading.value = true;
    print(email);

    await users.doc(email).update({
      "fullName": name,
      "phoneNo": noHp,
      "spesialis": spesialis,
      "biografi": biografi
    });

    await authR.userUpdate(name, noHp, spesialis, biografi);
    loading.value = false;
    // update model
  }
}

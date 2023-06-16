import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_dokter/app/database/authentication/authentication_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AccountSettingsController extends GetxController {
  //TODO: Implement AccountSettingsController

  FirebaseStorage storage = FirebaseStorage.instance;
  final repo = Get.put(AuthenticationRepository());

  late TextEditingController emailC;
  late TextEditingController nameC;
  late TextEditingController passwordC;
  late TextEditingController noHpC;
  late TextEditingController division;
  late TextEditingController company;
  late ImagePicker imagePicker;
  RxBool loading = false.obs;

  XFile? imagePicked;

  @override
  void onInit() {
    emailC = TextEditingController();
    nameC = TextEditingController();
    division = TextEditingController();
    company = TextEditingController();
    passwordC = TextEditingController();
    noHpC = TextEditingController();
    imagePicker = ImagePicker();
    super.onInit();
  }

  @override
  void onClose() {
    emailC.dispose();
    nameC.dispose();
    division.dispose();
    company.dispose();
    noHpC.dispose();
    passwordC.dispose();
    super.onClose();
  }

  Future<void> uploadImage(String uid) async {
    Reference storageRef = storage.ref("$uid.png");
    File file = File(imagePicked!.path);

    try {
      await storageRef.putFile(file);
      final url = await storageRef.getDownloadURL();
      await repo.userUpdatePhoto(url);
    } catch (e) {
      print(e);
    }
  }

  void selectImage() async {
    try {
      final dataImage =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (dataImage != null) {
        dataImage.name;
        imagePicked = dataImage;
        update();
      }
      update();
    } catch (e) {
      print("error $e");
      imagePicked = null;
      update();
    }
  }

  void cancel() {
    imagePicked = null;
    update();
  }

  void changeProfile(String name, String noHp, String division, String company,
      String email) async {
    final authR = Get.put(AuthenticationRepository());
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    loading.value = true;

    await users.doc(email).update({
      "fullName": name,
      "phoneNo": noHp,
      "division": division,
      "companyName": company
    });

    await authR.userUpdate(name, noHp, division, company);
    loading.value = false;
    // update model
  }
}

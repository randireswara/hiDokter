import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_dokter/app/database/authentication/authentication_repository.dart';

import '../../data/model/user_model.dart';

class CheckUser extends GetxController {
  static CheckUser get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void checkUser(String email, String password) async {
    CollectionReference users = _db.collection("Users");

    final checkUser = await users.where("email", isEqualTo: email).get();
    final docs = checkUser.docs;

    List<Map<String, dynamic>> data =
        docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    String role = await data[0]['role'];

    if (role == "pasien") {
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email, password);
    } else {
      await AuthenticationRepository.instance
          .loginWithEmailAndPasswordDok(email, password);
    }
  }

  createUser(UserModel user) async {
    await _db
        .collection("Users")
        .add(user.toJson())
        .whenComplete(() => Get.snackbar(
            "Success", "You account has been created",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green))
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try Again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }
}

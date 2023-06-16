import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_dokter/app/data/model/notification_model.dart';
import 'package:hi_dokter/app/database/authentication/authentication_repository.dart';

class NotificationPageController extends GetxController {
  //TODO: Implement NotificationPageController

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<NotificationModel> model = RxList<NotificationModel>();

  final repo = Get.put(AuthenticationRepository());

  Stream<QuerySnapshot<Map<String, dynamic>>> streamNotification(email) {
    return firestore
        .collection("Users")
        .doc(email)
        .collection("notification")
        .orderBy("createdAT", descending: true)
        .snapshots();
  }

  void readNotification(email) async {
    try {
      final snapshot = await firestore
          .collection("Users")
          .doc(email)
          .collection("notification")
          .where("isRead", isEqualTo: false)
          .get();

      snapshot.docs.forEach((element) async {
        await firestore
            .collection("Users")
            .doc(email)
            .collection("notification")
            .doc(element.id.toString())
            .update({
          "isRead": true,
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    readNotification(repo.userModel.value.email);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import '../../../services/notification_service.dart';

class MedicineReminderController extends GetxController {
  //TODO: Implement MedicineReminderController

  Rx<DateTime> selectedDate = DateTime.now().obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final LocalNotificationService service;
  @override
  void onInit() {
    // TODO: implement onInit
    service = LocalNotificationService();
    service.intialize();
    super.onInit();
  }

  void selected(DateTime date) {
    selectedDate.value = date;
    print(selectedDate.value);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getData(email) {
    return firestore
        .collection("Users")
        .doc(email)
        .collection("MedicineReminder")
        .snapshots();
  }

  void refreshData() {
    // Lakukan pembaruan data di sini
    update();
  }

  void deleteTask(email, id) {
    firestore
        .collection("Users")
        .doc(email)
        .collection("MedicineReminder")
        .doc(id)
        .delete();
  }
}

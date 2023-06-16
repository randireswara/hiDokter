import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeDokterScreenController extends GetxController {
  //TODO: Implement HomeDokterScreenController

  final selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAppointment(
      email, String date) {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection("bookAppointment")
        .where("status", isEqualTo: "upcoming")
        .where("day", isEqualTo: date)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> unreadNotification(email) {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection("notification")
        .where("isRead", isEqualTo: false)
        .snapshots();
  }

  Future<String> getPhoto(emailPasien) async {
    try {
      final data = await FirebaseFirestore.instance
          .collection("Users")
          .doc(emailPasien)
          .get();

      String photo = data.data()!["photoUrl"];
      return photo;
    } catch (e) {
      print(e);
    }
    return "kosong";
  }
}

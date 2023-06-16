import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final selectedIndex = 0.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> homeStream(String email) {
    return firestore.collection('Users').doc(email).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> newsStream() {
    return firestore.collection('News').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> unreadNotification(email) {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection("notification")
        .where("isRead", isEqualTo: false)
        .snapshots();
  }
}

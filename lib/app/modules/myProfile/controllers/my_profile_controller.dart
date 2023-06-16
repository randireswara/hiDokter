import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MyProfileController extends GetxController {
  //TODO: Implement MyProfileController

  Stream<DocumentSnapshot<Map<String, dynamic>>> profileStream(String email) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .snapshots();
  }
}

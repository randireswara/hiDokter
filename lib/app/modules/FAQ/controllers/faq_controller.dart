import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FaqController extends GetxController {
  //TODO: Implement FaqController
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> chatStream() {
    return firestore.collection('Faq').snapshots();
  }
}

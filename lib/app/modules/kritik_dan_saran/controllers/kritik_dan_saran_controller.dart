import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class KritikDanSaranController extends GetxController {
  //TODO: Implement KritikDanSaranController

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> uploadKritik(String email, String saran, String pengirim) {
    return sendData(email, saran, pengirim);
  }

  Future<void> sendData(String email, String saran, String pengirim) {
    return firestore.collection("Kritik").add({
      "email": email,
      "saran": saran,
      "pengirim": pengirim,
    });
  }
}

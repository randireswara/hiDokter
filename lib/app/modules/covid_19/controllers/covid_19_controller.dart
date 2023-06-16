import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hi_dokter/app/database/authentication/authentication_repository.dart';

class Covid19Controller extends GetxController {
  //TODO: Implement Covid19Controller
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final repo = Get.put(AuthenticationRepository());

  Stream<DocumentSnapshot<Map<String, dynamic>>> aboutCovid() {
    return firestore.collection("covid19").doc("doc1").snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> mencegahCovid() {
    return firestore.collection("covid19").doc("doc2").snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> mengobatiCovid() {
    return firestore.collection("covid19").doc("doc3").snapshots();
  }

  Future<void> sendCovidForm(String email, bool fever, bool cough, bool breath,
      bool troath, bool fatigue) {
    return firestore
        .collection("covid19")
        .doc("penderitaCovid")
        .collection("covid19Form")
        .add({
      'email': email,
      'apakahDemam': fever,
      'apakahBatuk': cough,
      'apakahSesak': breath,
      'apakahSakitTenggorokan': troath,
      'apakahKelelahan': fatigue,
      'noTelpon': repo.userModel.value.phoneNo
    });
  }
}

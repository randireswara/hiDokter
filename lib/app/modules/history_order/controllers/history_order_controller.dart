import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HistoryOrderController extends GetxController {
  //TODO: Implement HistoryOrderController

  //snapshot dan nge stream untuk yang completed dan tidak completed

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getDataUpcoming(email) {
    return firestore
        .collection("Users")
        .doc(email)
        .collection("bookAppointment")
        .where("status", isEqualTo: "upcoming")
        .orderBy("day", descending: true)
        .snapshots();
  }

  Future<String> getPhoto(emailDokter) async {
    try {
      final data = await firestore.collection("Users").doc(emailDokter).get();

      String photo = data.data()!["photoUrl"];
      return photo;
    } catch (e) {
      print(e);
    }
    return "kosong";
  }

  Future<Map> getNameAndSpesialis(emailDokter) async {
    try {
      final data = await firestore.collection("Users").doc(emailDokter).get();

      String name = data.data()!["fullName"];
      String spesialis = data.data()!["spesialis"];

      return {"name": name, "spesialis": spesialis};
    } catch (e) {
      print(e);
    }
    return {};
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getDataCompleted(email) {
    return firestore
        .collection("Users")
        .doc(email)
        .collection("bookAppointment")
        .where("status", isEqualTo: "completed")
        .orderBy("day", descending: true)
        .snapshots();
  }

  Future<void> deleteTask(doc, email, emailDokter) async {
    // delete both dokter and pasien
    firestore
        .collection("Users")
        .doc(email)
        .collection("bookAppointment")
        .doc(doc)
        .delete();

    firestore
        .collection("Users")
        .doc(emailDokter)
        .collection("bookAppointment")
        .doc(doc)
        .delete();

    // send notification both
    firestore.collection("Users").doc(email).collection("notification").add({
      "title": "Succes",
      "subtitle": "succes delete appointment",
      "createdAT": DateTime.now().toString(),
      "isRead": false,
    });

    firestore
        .collection("Users")
        .doc(emailDokter)
        .collection("notification")
        .add({
      "title": "Appointment Canceled",
      "subtitle": "your patient has cancel appointment",
      "createdAT": DateTime.now().toString(),
      "isRead": false,
    });
  }
}

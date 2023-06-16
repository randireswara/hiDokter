import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HistoryPatientController extends GetxController {
  //TODO: Implement HistoryPatientController

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

  Stream<QuerySnapshot<Map<String, dynamic>>> getDataCompleted(email) {
    return firestore
        .collection("Users")
        .doc(email)
        .collection("bookAppointment")
        .where("status", isEqualTo: "completed")
        .orderBy("day", descending: true)
        .snapshots();
  }

  Future<void> deleteTask(doc, email, emailPasien) async {
    // delete both dokter and pasien
    await firestore
        .collection("Users")
        .doc(email)
        .collection("bookAppointment")
        .doc(doc)
        .delete();
    print("1");

    await firestore
        .collection("Users")
        .doc(emailPasien)
        .collection("bookAppointment")
        .doc(doc)
        .delete();
    print("2");

    // send notification both
    await firestore
        .collection("Users")
        .doc(email)
        .collection("notification")
        .add({
      "title": "Success",
      "subtitle": "Success delete appointment",
      "createdAT": DateTime.now().toString(),
      "isRead": false,
    });
    print("3");

    await firestore
        .collection("Users")
        .doc(emailPasien)
        .collection("notification")
        .add({
      "title": "Appointment Cancel",
      "subtitle": "Iam sorry doctor has canceled your appointment",
      "createdAT": DateTime.now().toString(),
      "isRead": false,
    });

    print("4");
  }

  Future<String> getPhoto(emailPasien) async {
    try {
      final data = await firestore.collection("Users").doc(emailPasien).get();

      String photo = data.data()!["photoUrl"];
      return photo;
    } catch (e) {
      print(e);
    }
    return "kosong";
  }

  Future<void> completeTask(doc, email, emailPasien, namaDokter) async {
    // delete both dokter and pasien
    await firestore
        .collection("Users")
        .doc(email)
        .collection("bookAppointment")
        .doc(doc)
        .update({"status": "completed"});
    print("1");

    await firestore
        .collection("Users")
        .doc(emailPasien)
        .collection("bookAppointment")
        .doc(doc)
        .update({"status": "completed"});
    print("2");

    // send notification both
    await firestore
        .collection("Users")
        .doc(email)
        .collection("notification")
        .add({
      "title": "Success",
      "subtitle": "Success completed appointment",
      "createdAT": DateTime.now().toString(),
      "isRead": false,
    });
    print("3");

    await firestore
        .collection("Users")
        .doc(emailPasien)
        .collection("notification")
        .add({
      "title": "Appointment Completed",
      "subtitle": "Your Appointment with $namaDokter is Completed",
      "createdAT": DateTime.now().toString(),
      "isRead": false,
    });

    print("4");
  }
}

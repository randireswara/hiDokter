import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_dokter/app/modules/list_chat_for_pasien/views/chat_pasien_view.dart';
import 'package:hi_dokter/app/routes/app_pages.dart';

class ChatPasienController extends GetxController {
  //TODO: Implement ChatPasienController

  TextEditingController search = TextEditingController();
  RxString tempSearch = ''.obs;
  RxInt unreadvalue = 0.obs;
  RxString lastUpdate = "".obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> streamDataDokter() {
    return firestore
        .collection("Users")
        .where("role", isEqualTo: "dokter")
        .where("isOnline", isEqualTo: true)
        .snapshots();
  }

  // Stream<Map<dynamic, dynamic>> getUnreadAndHour(
  //     emailPasien, emailPengirim)  {
  //   // ambil

  //   // cari dokumentasi
  //   final cekDulu = await firestore
  //       .collection("chat")
  //       .where("emailPasien", isEqualTo: emailPasien)
  //       .where("emailDokter", isEqualTo: emailPengirim)
  //       .get();

  //   final docs = cekDulu.docs;

  //   List<String> ids = [];
  //   docs.forEach((doc) {
  //     ids.add(doc.id);
  //   });

  //   Map hasil = {};

  //   if (ids.isNotEmpty) {
  //     final snapshot = await firestore.collection("chat").doc(ids[0]).get();
  //     final data = snapshot.data();

  //     final jam = data!["lastUpdate"];

  //     final snapshot2 = await firestore
  //         .collection("chat")
  //         .doc(ids[0])
  //         .collection("detailChat")
  //         .where("pengirim", isEqualTo: emailPengirim)
  //         .where("isRead", isEqualTo: false)
  //         .get();

  //     final unread = snapshot2.size;
  //     print("unread $unread");

  //     hasil = {"jam": jam, "unread": unread};
  //   }
  //   return hasil;
  // }

  Stream<Map<dynamic, dynamic>> getUnreadAndHour2(
      emailPasien, emailPengirim) async* {
    // Cari dokumentasi
    final cekDulu = await firestore
        .collection("chat")
        .where("emailPasien", isEqualTo: emailPasien)
        .where("emailDokter", isEqualTo: emailPengirim)
        .get();

    final docs = cekDulu.docs;

    List<String> ids = [];
    docs.forEach((doc) {
      ids.add(doc.id);
    });

    if (ids.isNotEmpty) {
      final snapshot = await firestore.collection("chat").doc(ids[0]).get();
      final data = snapshot.data();

      final jam = data!["lastUpdate"];

      yield {
        "jam": jam,
        "unread": null
      }; // Kirim data awal dengan unread = null

      await for (var snapshot2 in firestore
          .collection("chat")
          .doc(ids[0])
          .collection("detailChat")
          .where("pengirim", isEqualTo: emailPengirim)
          .where("isRead", isEqualTo: false)
          .snapshots()) {
        final unread = snapshot2.size;
        print("unread $unread");

        yield {
          "jam": jam,
          "unread": unread
        }; // Kirim data dengan unread terbaru
      }
    } else {
      yield {
        "jam": null,
        "unread": null
      }; // Kirim data awal dengan jam dan unread = null
    }
  }

  void searchTemp(alphabet) {
    tempSearch.value = alphabet;
  }

  Future<void> goToChatRoom(String emailPasien, String emailDokter, String name,
      String namaPasien, String photoUrl) async {
    final cekDulu = await firestore
        .collection("chat")
        .where("emailPasien", isEqualTo: emailPasien)
        .where("emailDokter", isEqualTo: emailDokter)
        .get();

    final docs = cekDulu.docs;

    List<String> ids = [];

    docs.forEach((doc) {
      ids.add(doc.id);
    });

    if (ids.isEmpty) {
      await firestore.collection("chat").add({
        "emailPasien": emailPasien,
        "emailDokter": emailDokter,
        "lastUpdate": DateTime.now().toIso8601String(),
        "namaPasien": namaPasien,
        "photoUrl": photoUrl
      }).then((value) {
        Map<String, dynamic> arguments = {
          'namaPenerima': name,
          'emailPenerima': emailDokter,
          'emailPengirim': emailPasien,
          'idChat': value.id,
          'photoUrl': photoUrl
        };
        Get.toNamed(Routes.ROOM_CHAT, arguments: arguments);
        unreadvalue.value = 0;
      });
    } else {
      Map<String, dynamic> arguments = {
        'namaPenerima': name,
        'emailPenerima': emailDokter,
        'emailPengirim': emailPasien,
        'idChat': ids[0],
        'photoUrl': photoUrl
      };
      Get.toNamed(Routes.ROOM_CHAT, arguments: arguments);
      unreadvalue.value = 0;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
}

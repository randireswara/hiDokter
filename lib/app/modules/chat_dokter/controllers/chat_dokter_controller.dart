import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ChatDokterController extends GetxController {
  //TODO: Implement ChatDokterController
  RxString search = "".obs;
  TextEditingController searchText = TextEditingController();

  // cari pasien yang ngechat duluan
  // tampilkan pasien yang ngechat duluan
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var dataList = [];
  RxInt unRead = 0.obs;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamList(emailDokter) {
    return firestore
        .collection("chat")
        .where("emailDokter", isEqualTo: emailDokter)
        .orderBy("lastUpdate", descending: true)
        .snapshots();
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

  searchFunc(value) {
    search.value = value;
  }

  deleteSearch() {
    search.value = "";
  }

  goToRoomChat(String emailPasien, String emailDokter, String idChat,
      String namaPasien) async {
    Map<String, dynamic> arguments = {
      'namaPenerima': namaPasien,
      'emailPenerima': emailPasien,
      'emailPengirim': emailDokter,
      'idChat': idChat
    };
    unRead.value = 0;
    Get.toNamed(Routes.ROOM_CHAT, arguments: arguments);
  }

  Future<int> totalRead(idChat, emailPasien) async {
    var snapshot = await firestore
        .collection("chat")
        .doc(idChat)
        .collection("detailChat")
        .where("isRead", isEqualTo: false)
        .where("pengirim", isEqualTo: emailPasien)
        .get();

    var total = snapshot.size;

    unRead.value = total;
    print("total $total");
    return total;
  }

  Stream<Map<dynamic, dynamic>> getUnreadAndHour2(idChat, emailPasien) async* {
    // Cari dokumentasi

    await for (var snapshot2 in firestore
        .collection("chat")
        .doc(idChat)
        .collection("detailChat")
        .where("pengirim", isEqualTo: emailPasien)
        .where("isRead", isEqualTo: false)
        .snapshots()) {
      final unread = snapshot2.size;

      yield {"unread": unread}; // Kirim data dengan unread terbaru
    }
  }
}

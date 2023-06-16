import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hi_dokter/app/database/authentication/authentication_repository.dart';
import 'package:hi_dokter/app/modules/chat_dokter/controllers/chat_dokter_controller.dart';
import 'package:hi_dokter/app/modules/list_chat_for_pasien/controllers/chat_pasien_controller.dart';
import 'package:intl/intl.dart';

class RoomChatController extends GetxController {
  //TODO: Implement RoomChatController
  late ScrollController scrollC;
  late FocusNode focusNode;
  TextEditingController textField = TextEditingController();
  String namaPenerima = '';
  String pengirim = '';
  String emailPenerima = '';
  String idChat = '';
  final repo = Get.put(AuthenticationRepository());
  final listForPasienCon = Get.put(ChatPasienController());
  final listForDokterCon = Get.put(ChatDokterController());

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    namaPenerima = Get.arguments["namaPenerima"];
    emailPenerima = Get.arguments["emailPenerima"];
    idChat = Get.arguments["idChat"];

    focusNode = FocusNode();
    scrollC = ScrollController();
    if (focusNode.hasFocus) {
      scrollC.animateTo(
        scrollC.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
    readChat(emailPenerima, idChat);
  }

  @override
  void onClose() {
    focusNode.removeListener(_onFocusChange);
    focusNode.dispose();
    super.onClose();
    changeRead(repo.userModel.value.role, repo.userModel.value.email);
  }

  void changeRead(role, emailPasien) {
    print(role);
    if (role == "dokter") {
      listForDokterCon.totalRead(idChat, emailPenerima);
    }
  }

  void _onFocusChange() {
    if (!focusNode.hasFocus) {
      // Tutup keyboard saat pengguna meninggalkan halaman
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
  }

  Future<String> getPhoto(emailPenerima) async {
    try {
      final data = await firestore.collection("Users").doc(emailPenerima).get();

      String photo = data.data()!["photoUrl"];
      return photo;
    } catch (e) {
      print(e);
    }
    return "kosong";
  }

  //is read dari pengirim harus dirubah ke 0
  void readChat(emailPengirim, docChat) async {
    try {
      final snapshot = await firestore
          .collection("chat")
          .doc(docChat)
          .collection("detailChat")
          .where("pengirim", isEqualTo: emailPengirim)
          .get();

      snapshot.docs.forEach((element) async {
        await firestore
            .collection("chat")
            .doc(docChat)
            .collection("detailChat")
            .doc(element.id.toString())
            .update({
          "isRead": true,
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void sendData(String uid, String msg, String penerima, String pengirim,
      String namaPengirim) {
    final date = DateTime.now().toIso8601String();
    firestore.collection("chat").doc(uid).collection("detailChat").add({
      "pengirim": pengirim,
      "penerima": penerima,
      "msg": msg,
      "time": date,
      "groupTime": DateFormat.yMMMd('en_US').format(DateTime.parse(date)),
      "isRead": false
    });

    firestore.collection("chat").doc(uid).update({"lastUpdate": date});

    Timer(
        Duration.zero, () => scrollC.jumpTo(scrollC.position.maxScrollExtent));

    firestore.collection("Users").doc(penerima).collection("notification").add({
      "createdAT": DateTime.now().toString(),
      "isRead": false,
      "subtitle": "new chat from $namaPengirim",
      "title": "new chat"
    });

    textField.clear();
  }

  void getMap(String nama, String email, String id) {
    namaPenerima = nama;
    emailPenerima = email;
    idChat = id;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamChat(uid) {
    return firestore
        .collection("chat")
        .doc(uid)
        .collection("detailChat")
        .orderBy("time")
        .snapshots();
  }

  void scroll() {
    Timer(
        Duration.zero, () => scrollC.jumpTo(scrollC.position.maxScrollExtent));
  }
}

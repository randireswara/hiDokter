import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PilihanDokterController extends GetxController {
  //TODO: Implement PilihanDokterController

  final TextEditingController searchController = TextEditingController();

  var tempSearch = ''.obs;
  final padding = 5.0.obs;

  // tampilkan seluruh data dokter yang tersedia
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamDataDokter() {
    return firestore
        .collection("Users")
        .where("role", isEqualTo: "dokter")
        .where("bookAppointment", isEqualTo: true)
        .snapshots();
  }

  void search(alphabet) {
    tempSearch.value = alphabet;
    print(tempSearch.value);
  }
}

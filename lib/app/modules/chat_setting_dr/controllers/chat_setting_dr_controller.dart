import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatSettingDrController extends GetxController {
  //TODO: Implement ChatSettingDrController

  RxBool switchValue = false.obs;
  BuildContext? context = Get.context;

  RxString startTime = "".obs;
  RxString endTime = "".obs;

  getTimeFromUser(String fromWhere) async {
    var pickedTime = await showTimePickerFunc();

    if (pickedTime == null) {
      print("time canceled");
    } else if (fromWhere == "start") {
      // startTime.value = pickedTime.format(context!);
      startTime.value = pickedTime.format(context!).toString();

      print("start TImes $startTime");
    } else if (fromWhere == "end") {
      endTime.value = pickedTime.format(context!).toString();
    }
  }

  Future<TimeOfDay?> showTimePickerFunc() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context!,
        initialTime: TimeOfDay.now());
  }

  void getSwitch(value) {
    switchValue.value = value;
  }

  void getHourFromDb(email) async {
    var snapshot =
        await FirebaseFirestore.instance.collection("Users").doc(email).get();

    var data = snapshot.data();

    final jamBuka = data!['jamBuka'];
    final jamTutup = data['jamTutup'];
    bool isOnline = data['isOnline'];

    startTime.value = jamBuka;
    endTime.value = jamTutup;
    switchValue.value = isOnline;
  }

  void sendDataToDb(email, isOnline, jamBuka, jamTutup) async {
    try {
      await FirebaseFirestore.instance.collection("Users").doc(email).update({
        'isOnline': isOnline,
        'jamBuka': jamBuka,
        'jamTutup': jamTutup
      }).then((_) => Get.snackbar("succes save", "setting has been updated"));
    } catch (e) {
      return print(e);
    }
  }

  void defaultSet() {
    startTime.value = "";
    endTime.value = "";
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHourFromDb(Get.arguments);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    defaultSet();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    defaultSet();
  }
}

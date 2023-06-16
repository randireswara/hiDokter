import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddReminderController extends GetxController {
  //TODO: Implement AddReminderController

  TextEditingController namaObat = TextEditingController();
  TextEditingController lamaHari = TextEditingController();
  RxInt pilihanRadio = 1.obs;
  RxList<dynamic> reminderTimes =
      [DateFormat("hh:mm a").format(DateTime.now()).toString()].obs;
  RxString startTime =
      DateFormat("hh:mm a").format(DateTime.now()).toString().obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  int currentStep = 0;
  bool showFirstForm = true;
  bool showSecondForm = false;
  RxBool loading = false.obs;

  void setSelectedValue(int value) {
    pilihanRadio.value = value;
    reminderTimes.clear();

    if (value == 1) {
      reminderTimes.addAll(["$startTime"].cast<String>());
      pilihanRadio.value = value;
      print(reminderTimes);
    } else if (value == 2) {
      reminderTimes.addAll(["$startTime", "$startTime"].cast<String>());
      print(reminderTimes);
      pilihanRadio.value = value;
    } else if (value == 3) {
      reminderTimes
          .addAll(["$startTime", "$startTime", "$startTime"].cast<String>());
      pilihanRadio.value = value;
    }

    // konversi tipe data dari List<dynamic> ke Iterable<String>
    reminderTimes.refresh();
  }

  getTimeFromUser(int index, BuildContext context) async {
    var pickedTime = await showTimePickerFunc(context);

    if (pickedTime == null) {
      print("time canceled");
    } else {
      String formattedTime = pickedTime.format(context);
      reminderTimes[index] = formattedTime;

      print("Reminder Times $reminderTimes");
    }
  }

  Future<TimeOfDay?> showTimePickerFunc(BuildContext context) {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay.now());
  }

  getDateFromUser(BuildContext context) async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2025),
    );

    if (pickerDate != null) {
      selectedDate.value = pickerDate;
    } else {
      print("its null or something went wrong");
    }
  }

  void sendData(String email, String drugName, String longDay, int howManyTime,
      List hour, String startDay) async {
    loading.value = true;
    print("tes send Data");

    print(email);
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection("MedicineReminder")
        .add({
      "drugName": drugName,
      "longDay": longDay,
      "howManyTime": howManyTime,
      "hour": hour,
      "startDay": startDay,
      "isCompleted": false
    });
    loading.value = false;
  }
}

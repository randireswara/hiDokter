import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_dokter/app/modules/detail_dokter/controllers/detail_dokter_controller.dart';
import 'package:hi_dokter/app/modules/home/views/home_view.dart';
import 'package:hi_dokter/app/routes/app_pages.dart';
import 'package:table_calendar/table_calendar.dart';

class BookAppointmentController extends GetxController {
  //TODO: Implement BookAppointmentController

  final Rx<CalendarFormat> format1 = CalendarFormat.month.obs;
  Rx<DateTime> focusDay = DateTime.now().obs;
  Rx<DateTime> currentDay = DateTime.now().obs;
  RxInt currentIndex = 0.obs;
  RxString hourSelected = "".obs;
  final RxBool isWeekend = false.obs;
  final RxBool dateSelected = false.obs;
  final RxBool timeSelected = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final controller = Get.put(DetailDokterController());
  RxString hourAvailable = "".obs;

  //bagaimana date selected dan is weekend bisa sama2 true

  @override
  void onInit() async {
    super.onInit();

    onDaySelected(currentDay.value, focusDay.value);
    updateIndexTime("9:00 AM", 0);
    await getDataHour(controller.appointmentModel.emailDokter);
  }

  void onFormatChange(format) {
    format1.value = format;
  }

  Future<void> getDataHour(emailDOkter) async {
    final data = await firestore.collection("Users").doc(emailDOkter).get();
    String hourOpen = data.data()!["bukaJanjiTemu"];
    String hourClose = data.data()!["tutupJanjiTemu"];
    String hour = "$hourOpen - $hourClose";
    print(hour);
    hourAvailable.value = hour;
  }

  void onDaySelected(selectedDay, focusedDay) {
    currentDay.value = selectedDay;
    focusDay.value = focusedDay;
    dateSelected.value = true;
    print(selectedDay.weekday);

    if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
      isWeekend.value = true;
      timeSelected.value = false;
      currentIndex.value = 0;
    } else {
      isWeekend.value = false;
    }
  }

  void updateIndexTime(String jam, int index) {
    currentIndex.value = index;
    timeSelected.value = true;
    hourSelected.value = jam;
  }

  Future<void> sendDataAppointment(
    String day,
    String hour,
    String emailPasien,
    String namaDokter,
    String emaildokter,
    String namaPasien,
    String spesialis,
  ) async {
    await firestore
        .collection("Users")
        .doc(emailPasien)
        .collection("bookAppointment")
        .add({
      "namaDokter": namaDokter,
      "namaPasien": namaPasien,
      "emailDokter": emaildokter,
      "emailPasien": emailPasien,
      "spesialis": spesialis,
      "hour": hour,
      "day": day,
      "status": "upcoming",
      "createdAt": DateTime.now(),
    }).then((value) {
      firestore
          .collection("Users")
          .doc(emaildokter)
          .collection("bookAppointment")
          .doc(value.id)
          .set({
        "namaDokter": namaDokter,
        "namaPasien": namaPasien,
        "emailDokter": emaildokter,
        "emailPasien": emailPasien,
        "hour": hour,
        "day": day,
        "status": "upcoming",
        "createdAt": DateTime.now(),
      });
    });

    await firestore
        .collection("Users")
        .doc(emailPasien)
        .collection("notification")
        .add({
      "title": "Succes",
      "subtitle": "succes add appointment",
      "createdAT": DateTime.now().toString(),
      "isRead": false,
    });

    await firestore
        .collection("Users")
        .doc(emaildokter)
        .collection("notification")
        .add({
      "title": "New Appointment",
      "subtitle": "$namaPasien has make appointment with you",
      "createdAT": DateTime.now().toString(),
      "isRead": false,
    });
  }
}

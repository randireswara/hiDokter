import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';

class AppointmentSettingController extends GetxController {
  //TODO: Implement AppointmentSettingController

  RxBool switchValue = false.obs;

  RxString startTime = "".obs;
  RxString endTime = "".obs;

  BuildContext? context = Get.context;

  RxString selectedDay = "Senin".obs;
  RxString selectedDay2 = "Senin".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getHourFromDb(Get.arguments);
  }

  changeDay(value) {
    selectedDay.value = value;
  }

  changeDay2(value) {
    selectedDay2.value = value;
  }

  void sendDataToDb(email, isTrue, jamBuka, jamTutup, hariBuka) async {
    try {
      await FirebaseFirestore.instance.collection("Users").doc(email).update({
        'bookAppointment': isTrue,
        'bukaJanjiTemu': jamBuka,
        'tutupJanjiTemu': jamTutup,
        'dayOpen': hariBuka
      }).then((_) => Get.snackbar("succes save", "setting has been updated"));
    } catch (e) {
      return print(e);
    }
  }

  void getDataFromDb(email) async {
    var snapshot =
        await FirebaseFirestore.instance.collection("Users").doc(email).get();

    var data = snapshot.data();

    bool isAvailable = data!['bookAppointment'];

    switchValue.value = isAvailable;
  }

  void getSwitch(value) {
    switchValue.value = value;
  }

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

  void getHourFromDb(email) async {
    var snapshot =
        await FirebaseFirestore.instance.collection("Users").doc(email).get();

    var data = snapshot.data();

    final jamBuka = data!['bukaJanjiTemu'];
    final jamTutup = data['tutupJanjiTemu'];
    bool isOnline = data['bookAppointment'];
    String inputString = data['dayOpen'];

    List<String> splitStrings = inputString.split(' - ');

    String firstPart = splitStrings[0]; // Bagian pertama
    String secondPart = splitStrings[1]; // Bagian kedua

    selectedDay.value = firstPart;
    selectedDay2.value = secondPart;

    startTime.value = jamBuka;
    endTime.value = jamTutup;
    switchValue.value = isOnline;
  }
}

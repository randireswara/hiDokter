import 'package:get/get.dart';

class NotificationPermissionController extends GetxController {
  //TODO: Implement NotificationPermissionController

  RxBool switchValue = false.obs;

  void getSwitch(value) {
    switchValue.value = value;
  }
}

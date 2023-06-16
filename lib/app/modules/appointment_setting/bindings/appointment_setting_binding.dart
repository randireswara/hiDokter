import 'package:get/get.dart';

import '../controllers/appointment_setting_controller.dart';

class AppointmentSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentSettingController>(
      () => AppointmentSettingController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/add_reminder_controller.dart';

class AddReminderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddReminderController>(
      () => AddReminderController(),
    );
  }
}

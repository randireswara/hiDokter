import 'package:get/get.dart';

import '../controllers/chat_setting_dr_controller.dart';

class ChatSettingDrBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatSettingDrController>(
      () => ChatSettingDrController(),
    );
  }
}

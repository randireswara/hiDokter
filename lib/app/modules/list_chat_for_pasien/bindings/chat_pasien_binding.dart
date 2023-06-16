import 'package:get/get.dart';

import '../controllers/chat_pasien_controller.dart';

class ChatPasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatPasienController>(
      () => ChatPasienController(),
    );
  }
}

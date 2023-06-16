import 'package:get/get.dart';

import '../controllers/chat_dokter_controller.dart';

class ChatDokterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatDokterController>(
      () => ChatDokterController(),
    );
  }
}

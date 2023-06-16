import 'package:get/get.dart';

import '../controllers/kritik_dan_saran_controller.dart';

class KritikDanSaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KritikDanSaranController>(
      () => KritikDanSaranController(),
    );
  }
}

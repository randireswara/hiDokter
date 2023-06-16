import 'package:get/get.dart';

import '../controllers/home_dokter_screen_controller.dart';

class HomeDokterScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeDokterScreenController>(
      () => HomeDokterScreenController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/pilihan_dokter_controller.dart';

class PilihanDokterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PilihanDokterController>(
      () => PilihanDokterController(),
    );
  }
}

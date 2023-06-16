import 'package:get/get.dart';

import '../controllers/pilih_konsultasi_controller.dart';

class PilihKonsultasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PilihKonsultasiController>(
      () => PilihKonsultasiController(),
    );
  }
}

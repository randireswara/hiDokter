import 'package:get/get.dart';

import '../controllers/history_patient_controller.dart';

class HistoryPatientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryPatientController>(
      () => HistoryPatientController(),
    );
  }
}

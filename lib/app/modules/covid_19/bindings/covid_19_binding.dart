import 'package:get/get.dart';

import '../controllers/covid_19_controller.dart';

class Covid19Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Covid19Controller>(
      () => Covid19Controller(),
    );
  }
}

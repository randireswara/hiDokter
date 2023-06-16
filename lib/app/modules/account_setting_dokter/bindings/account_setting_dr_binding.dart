import 'package:get/get.dart';

import '../controllers/account_setting_dr_controller.dart';

class AccountSettingDrBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountSettingDrController>(
      () => AccountSettingDrController(),
    );
  }
}

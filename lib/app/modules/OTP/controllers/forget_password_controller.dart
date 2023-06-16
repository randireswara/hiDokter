import 'package:get/get.dart';
import 'package:hi_dokter/app/routes/app_pages.dart';

import '../../../database/authentication/authentication_repository.dart';

class ForgetPasswordController extends GetxController {
  //TODO: Implement ForgetPasswordController

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAllNamed(Routes.HOME) : Get.back();
  }
}

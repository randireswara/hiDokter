import 'package:get/get.dart';
import 'package:hi_dokter/app/routes/app_pages.dart';

class FadeInController extends GetxController {
  static FadeInController get find => Get.find();

  RxBool animate = false.obs;

  Future startSplashAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 3000));
    animate.value = false;
    await Future.delayed(const Duration(milliseconds: 2000));
    Get.toNamed(Routes.INTRODUCTION_SCREEN);
  }

  Future startWelcomeScreenAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
  }
}

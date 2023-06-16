import 'package:get/get.dart';
import 'package:hi_dokter/app/routes/app_pages.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';

class IntroductionScreenController extends GetxController {
  //TODO: Implement IntroductionScreenController

  final controller = LiquidController();
  RxInt currentPage = 0.obs;

  void onPageChangeCallback(int activePageIndex) {
    currentPage.value = activePageIndex;
  }

  skip() => controller.jumpToPage(page: 2);

  animateToNextSlide() {
    int nextPage = controller.currentPage + 1;
    controller.animateToPage(page: nextPage);
  }

  finish() {
    Get.toNamed(Routes.LOGIN_SCREEN);
  }
}

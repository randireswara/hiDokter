import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hi_dokter/app/modules/introduction_screen/views/widget.dart';
import 'package:hi_dokter/app/routes/app_pages.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../data/model/model_introduction.dart';
import '../controllers/introduction_screen_controller.dart';

class IntroductionScreenView extends GetView<IntroductionScreenController> {
  const IntroductionScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List<OnBoardingPageWidget> introduction = [
      OnBoardingPageWidget(
        model: OnBoardingModel(
          image: "assets/images/intro_1.png",
          title: "Discover Top Doctors",
          subTitle: "All you need is here, the top doctor in Indonesia",
          counterText: "1/3",
          bgColor: Colors.white,
          height: size.height,
          buttonText: "Next",
        ),
        onTap: () => controller.animateToNextSlide(),
      ),
      OnBoardingPageWidget(
        model: OnBoardingModel(
            image: "assets/images/intro_2.png",
            title: "Ask a Doctor Online",
            subTitle:
                "You can ask doctor from everywhere, Hope this can help you",
            counterText: "2/3",
            bgColor: const Color.fromARGB(255, 255, 205, 205),
            height: size.height,
            buttonText: "Next"),
        onTap: () => controller.animateToNextSlide(),
      ),
      OnBoardingPageWidget(
        model: OnBoardingModel(
            image: "assets/images/intro_3.png",
            title: "Get Expert Advice",
            subTitle: "The best advice what's you want is in here",
            counterText: "3/3",
            bgColor: const Color.fromARGB(255, 255, 142, 142),
            height: size.height,
            buttonText: "Let's Start"),
        onTap: () {
          Get.offAllNamed(Routes.WELCOME_SCREEN);
        },
      ),
    ];

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: introduction,
            liquidController: controller.controller,
            slideIconWidget: const Icon(Icons.arrow_back),
            enableSideReveal: true,
            onPageChangeCallback: controller.onPageChangeCallback,
          ),
          // Positioned(
          //   bottom: 50.0,
          //   child: SizedBox(
          //     height: 70,
          //     child: OutlinedButton(
          //         onPressed: () => controller.animateToNextSlide(),
          //         style: ElevatedButton.styleFrom(
          //             side: const BorderSide(color: Colors.black26),
          //             shape: const CircleBorder(),
          //             padding: const EdgeInsets.all(20),
          //             foregroundColor: Colors.white),
          //         child: const Icon(
          //           Icons.arrow_forward_ios,
          //           color: Colors.black,
          //         )),
          //   ),
          // ),
          Positioned(
              top: 40,
              right: 20,
              child: TextButton(
                  onPressed: () => controller.skip(),
                  child: const Text(
                    "skip",
                    style: TextStyle(color: Colors.grey),
                  ))),
          Obx(
            () => Positioned(
                bottom: 10,
                child: AnimatedSmoothIndicator(
                  activeIndex: controller.currentPage.value,
                  count: 3,
                  effect: const WormEffect(
                      activeDotColor: Color(0xff272727), dotHeight: 5.0),
                )),
          )
        ],
      ),
    );
  }
}

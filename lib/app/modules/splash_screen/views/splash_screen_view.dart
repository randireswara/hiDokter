import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widget/fade_in_animation/animation_controller.dart';
import '../../../widget/fade_in_animation/fade_in_controller.dart';
import '../../../data/model/model_fade_in.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInController());
    controller.startSplashAnimation();
    return Scaffold(
      body: Stack(
        children: [
          FadeInAnimation(
            durationInMs: 1600,
            animatePosition: AnimatePosition(
                topAfter: 80, topBefore: 80, leftAfter: 30, leftBefore: -80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi Dokter",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  '"Di dalam tubuh yang sehat \n terdapat jiwa yang kuat"',
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
          ),
          FadeInAnimation(
            durationInMs: 1600,
            animatePosition: AnimatePosition(bottomAfter: 80, bottomBefore: 0),
            child: const SizedBox(
              width: 400,
              height: 400,
              child: Image(
                image: AssetImage("assets/images/logo_hidoc.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

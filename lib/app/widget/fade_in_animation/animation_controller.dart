import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'fade_in_controller.dart';
import '../../data/model/model_fade_in.dart';

class FadeInAnimation extends StatelessWidget {
  FadeInAnimation(
      {super.key,
      required this.durationInMs,
      this.animatePosition,
      required this.child});

  final controller = Get.put(FadeInController());
  final AnimatePosition? animatePosition;
  final int durationInMs;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedPositioned(
          duration: Duration(milliseconds: durationInMs),
          top: controller.animate.value
              ? animatePosition!.topAfter
              : animatePosition!.topBefore,
          left: controller.animate.value
              ? animatePosition!.leftAfter
              : animatePosition!.leftBefore,
          bottom: controller.animate.value
              ? animatePosition!.bottomAfter
              : animatePosition!.bottomBefore,
          right: controller.animate.value
              ? animatePosition!.rightAfter
              : animatePosition!.rightBefore,
          child: AnimatedOpacity(
            opacity: controller.animate.value ? 1 : 0,
            duration: Duration(milliseconds: durationInMs),
            child: child,
          ),
        ));
  }
}

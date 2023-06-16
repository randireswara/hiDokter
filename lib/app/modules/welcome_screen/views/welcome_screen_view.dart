import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hi_dokter/app/modules/signIn_screen/views/sign_in_screen_view.dart';
import 'package:hi_dokter/app/routes/app_pages.dart';

import '../../../data/model/model_fade_in.dart';
import '../../../widget/fade_in_animation/animation_controller.dart';
import '../../../widget/fade_in_animation/fade_in_controller.dart';
import '../controllers/welcome_screen_controller.dart';

class WelcomeScreenView extends StatelessWidget {
  const WelcomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInController());
    controller.startWelcomeScreenAnimation();
    var height1 = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      body: Stack(
        children: [
          FadeInAnimation(
            durationInMs: 1600,
            animatePosition: AnimatePosition(
                bottomAfter: 0,
                bottomBefore: -100,
                topAfter: 0,
                topBefore: 0,
                rightAfter: 0,
                rightBefore: 0,
                leftAfter: 0,
                leftBefore: 0),
            child: Container(
              padding: const EdgeInsets.all(30),
              color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(
                    image: const AssetImage("assets/images/welcome_foto.png"),
                    height: height1 * 0.6,
                  ),
                  Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            "Welcome To Hi Dokter",
                            style: Theme.of(context).textTheme.headlineSmall,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Find the best doctor, medicine, and health solution for you!",
                            style: Theme.of(context).textTheme.titleSmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Get.toNamed(Routes.LOGIN_SCREEN),
                              child: const Text(
                                "LOGIN",
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(() => const SignIn());
                              },
                              child: const Text("SIGN UP"),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

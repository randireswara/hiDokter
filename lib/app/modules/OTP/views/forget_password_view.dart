import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/forget_password_controller.dart';

class OTPScreen extends GetView<ForgetPasswordController> {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var otpController = Get.put(OTPController());
    var otp;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                "CO\nDE",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold, fontSize: 80.0),
              ),
              Text(
                "VERIFICATION",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Enter the verification code sent at here",
                textAlign: TextAlign.center,
                // textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20.0,
              ),
              OtpTextField(
                numberOfFields: 6,
                fillColor: Colors.black.withOpacity(0.1),
                filled: true,
                onSubmit: (value) {
                  otp = value;
                  controller.verifyOTP(otp);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      controller.verifyOTP(otp);
                    },
                    child: const Text("Next")),
              )
            ],
          ),
        ),
      ),
    );
  }
}

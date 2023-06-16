import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hi_dokter/app/modules/login_screen/controllers/login_screen_controller.dart';
import 'package:hi_dokter/app/modules/login_screen/views/forget_password.dart';
import 'package:hi_dokter/app/routes/app_pages.dart';

import '../../../data/model/user_model.dart';

class LoginScreenView extends GetView<LoginScreenController> {
  const LoginScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginScreenController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(children: [
                LoginHeaderWidget(size: size),
                const LoginForm(),
                const SizedBox(
                  height: 20,
                ),
                Image(
                  image: const AssetImage("assets/images/logo_ut.png"),
                  height: size.height * 0.2,
                ),
                // const LoginFromWidget()
              ])),
        ),
      ),
    );
  }
}

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: const AssetImage("assets/images/logo_hidoc.png"),
          height: size.height * 0.2,
        ),
        Text(
          "Welcome Back",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          "Continue To Login",
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}

class LoginForm extends GetView<LoginScreenController> {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: 'Email',
                  hintText: 'Email',
                  border: OutlineInputBorder()),
              controller: controller.email,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => TextFormField(
                  controller: controller.password,
                  obscureText: controller.obscureText.value,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else if (value.length < 7) {
                      return 'Password must be at least 7 characters long';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password_outlined),
                      labelText: 'Password',
                      hintText: 'Password',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.showPassword();
                          },
                          icon: controller.obscureText.value
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.black,
                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: Colors.black,
                                ))),
                )),
            const SizedBox(
              height: 2,
            ),
            Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.loginWithEmail(controller.email.text,
                            controller.password.text.trim());
                        print("controller = .email.text.trim()");
                      }
                    },
                    child: controller.loading.value
                        ? const CircularProgressIndicator()
                        : Text("Login")))),
            InkWell(
              onTap: () => Get.toNamed(Routes.SIGN_IN_SCREEN),
              child: Align(
                alignment: Alignment.center,
                child: Text.rich(
                  TextSpan(
                      text: "Dont Have An Account ?",
                      style: Theme.of(context).textTheme.bodySmall,
                      children: const [
                        TextSpan(
                            text: "Sign Up",
                            style: TextStyle(color: Colors.blue))
                      ]),
                ),
              ),
            ),
          ]),
        ));
  }

  Future<dynamic> showModalBottom(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Make Selection",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              "Select one of the options given below to reset your passsword",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            ForgetPassword(
              btnIcon: Icons.mail,
              title: "Email",
              subTitle: "Reset Via Email Verification",
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(Routes.FORGET_PASSWORD);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ForgetPassword(
              btnIcon: Icons.phone,
              title: "Phone",
              subTitle: "Reset Via Phone Verification",
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(Routes.FORGET_PASSWORD);
              },
            )
          ],
        ),
      ),
    );
  }
}

class LoginFromWidget extends StatelessWidget {
  const LoginFromWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("OR"),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Image(
              image: AssetImage("assets/images/google_logo.png"),
              width: 20,
            ),
            onPressed: () {},
            label: const Text("Sign In With Google"),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.toNamed(Routes.SIGN_IN_SCREEN);
          },
          child: Text.rich(
            TextSpan(
                text: "Dont Have An Account ?",
                style: Theme.of(context).textTheme.bodySmall,
                children: const [
                  TextSpan(
                      text: "Sign Up", style: TextStyle(color: Colors.blue))
                ]),
          ),
        )
      ],
    );
  }
}

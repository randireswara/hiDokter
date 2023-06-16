import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hi_dokter/app/database/authentication/authentication_repository.dart';

import '../controllers/security_controller.dart';

class SecurityView extends GetView<SecurityController> {
  const SecurityView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final repo = Get.put(AuthenticationRepository());
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Change Password',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.left,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Obx(() => TextFormField(
                        controller: controller.oldPass,
                        obscureText: controller.obscureText.value,
                        validator: (value) {
                          if (repo.userModel.value.password != value) {
                            return 'Write Your Password Correctly';
                          } else if (value!.length < 7) {
                            return 'Password must be at least 7 characters long';
                          }
                        },
                        decoration: InputDecoration(
                          label: Text("Current Password"),
                          prefixIcon: Icon(Icons.password),
                          border: UnderlineInputBorder(),
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
                                    )),
                          focusedBorder: UnderlineInputBorder(),
                        ),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(() => TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This Field is required';
                          }
                        },
                        controller: controller.newPass,
                        obscureText: controller.obscureText.value,
                        decoration: InputDecoration(
                          label: Text("New Password"),
                          prefixIcon: Icon(Icons.password),
                          border: UnderlineInputBorder(),
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
                                    )),
                          focusedBorder: UnderlineInputBorder(),
                        ),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(() => TextFormField(
                        controller: controller.entryNewPass,
                        obscureText: controller.obscureText.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This Field is required';
                          } else if (value != controller.newPass.text) {
                            return 'Password is different';
                          }
                        },
                        decoration: InputDecoration(
                          label: Text("Entry New Password"),
                          prefixIcon: Icon(Icons.password),
                          border: UnderlineInputBorder(),
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
                                    )),
                          focusedBorder: UnderlineInputBorder(),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              repo.changePassword(
                                controller.oldPass.text.trim(),
                                controller.newPass.text.trim(),
                              );
                              print(
                                  "controller = $controller.email.text.trim()");
                            }
                          },
                          child: const Text("Change Password")))
                ],
              ),
            )),
      ),
    );
  }
}

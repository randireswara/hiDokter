import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_dokter/app/database/authentication/authentication_repository.dart';

import '../controllers/account_settings_controller.dart';

class AccountSettingsView extends GetView<AccountSettingsController> {
  const AccountSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthenticationRepository());

    controller.emailC.text = authC.userModel.value.email!;
    controller.passwordC.text = authC.userModel.value.password!;
    controller.nameC.text = authC.userModel.value.fullName!;
    controller.noHpC.text = authC.userModel.value.phoneNo!;
    controller.division.text = authC.userModel.value.division!;
    controller.company.text = authC.userModel.value.companyName!;

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account Setting',
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
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Header(),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login Data",
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: controller.emailC,
                      readOnly: true,
                      decoration: const InputDecoration(
                          label: Text("Email"),
                          prefixIcon: Icon(Icons.email_rounded),
                          border: UnderlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      readOnly: true,
                      obscureText: true,
                      controller: controller.passwordC,
                      decoration: const InputDecoration(
                          label: Text("Password"),
                          prefixIcon: Icon(Icons.password),
                          border: UnderlineInputBorder(),
                          suffixIcon: Icon(Icons.remove_red_eye_outlined)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Personal Data",
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: controller.nameC,
                      decoration: const InputDecoration(
                          label: Text("Name"),
                          prefixIcon: Icon(Icons.person_2_outlined),
                          border: UnderlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This Field is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller.noHpC,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text("Phone Number"),
                        prefixIcon: Icon(Icons.phone_android),
                        border: UnderlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This Field is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Office Data",
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: controller.company,
                      decoration: const InputDecoration(
                          label: Text("Company Name"),
                          prefixIcon: Icon(Icons.place),
                          border: UnderlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This Field is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller.division,
                      decoration: const InputDecoration(
                        label: Text("Division"),
                        prefixIcon: Icon(Icons.group),
                        border: UnderlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This Field is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(() => SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  controller.changeProfile(
                                      controller.nameC.text,
                                      controller.noHpC.text,
                                      controller.division.text,
                                      controller.company.text,
                                      controller.emailC.text);
                                }
                              },
                              child: controller.loading.value
                                  ? const CircularProgressIndicator()
                                  : const Text("Update Data")),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountSettingsController());
    final repo = Get.put(AuthenticationRepository());
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          GetBuilder<AccountSettingsController>(
            builder: (c) => c.imagePicked == null
                ? Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Color.fromARGB(255, 255, 229, 229),
                        foregroundColor: Colors.black38,
                        backgroundImage: NetworkImage(repo.userModel.value
                            .photoUrl!), // ganti dengan path gambar lokal Anda
                      ),
                      TextButton(
                        onPressed: () {
                          c.selectImage();
                        },
                        child: const Text(
                          "Change Picture",
                          style: TextStyle(color: Colors.black54),
                        ),
                      )
                    ],
                  )
                : Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Color.fromARGB(255, 255, 229, 229),
                        foregroundColor: Colors.black38,
                        backgroundImage: FileImage(File(controller.imagePicked!
                            .path)), // ganti dengan path gambar lokal Anda
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                c.cancel();
                              },
                              icon: const Icon(Icons.cancel)),
                          IconButton(
                              onPressed: () {
                                c.uploadImage(repo.userModel.value.fullName!);
                              },
                              icon: const Icon(Icons.check)),
                        ],
                      )
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

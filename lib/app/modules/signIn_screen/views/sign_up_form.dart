import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_dokter/app/modules/signIn_screen/controllers/sign_in_screen_controller.dart';
import 'package:hi_dokter/app/modules/signIn_screen/views/sign_in_screen_view.dart';
import 'package:hi_dokter/app/routes/app_pages.dart';

import '../../../data/model/user_model.dart';
import '../../../database/authentication/authentication_repository.dart';

class SignUpFormWidget extends GetView<SignInScreenController> {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInScreenController());

    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This Field is required';
                  }
                  return null;
                },
                controller: controller.company,
                decoration: const InputDecoration(
                  label: Text("Company Name"),
                  prefixIcon: Icon(Icons.location_city),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This Field is required';
                  }
                  return null;
                },
                onEditingComplete: () {
                  final currentFocus = FocusScope.of(context);
                  currentFocus.unfocus();
                },
                controller: controller.division,
                decoration: const InputDecoration(
                  label: Text("Division"),
                  prefixIcon: Icon(Icons.work),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          )),
    );
  }
}

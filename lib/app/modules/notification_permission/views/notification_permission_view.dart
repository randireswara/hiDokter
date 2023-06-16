import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notification_permission_controller.dart';

class NotificationPermissionView
    extends GetView<NotificationPermissionController> {
  const NotificationPermissionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notification Permission',
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
      body: Obx(() => SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Enabled Notification",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Switch(
                    activeColor: Colors.amber,
                    value: controller.switchValue.value,
                    onChanged: (value) {
                      controller.getSwitch(value);
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}

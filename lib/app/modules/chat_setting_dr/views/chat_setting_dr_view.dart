import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hi_dokter/app/database/authentication/authentication_repository.dart';

import '../controllers/chat_setting_dr_controller.dart';

class ChatSettingDrView extends GetView<ChatSettingDrController> {
  const ChatSettingDrView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat Setting',
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
        actions: [
          InkWell(
              onTap: () => controller.sendDataToDb(
                  Get.arguments,
                  controller.switchValue.value,
                  controller.startTime.value,
                  controller.endTime.value),
              child: const Padding(
                padding: EdgeInsets.only(right: 10, top: 5),
                child: Icon(
                  Icons.save,
                  color: Colors.black,
                ),
              ))
        ],
      ),
      body: Obx(() => Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Status",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Disabled or enable your chat with any patience",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        activeColor: Colors.amber,
                        value: controller.switchValue.value,
                        onChanged: (value) {
                          controller.getSwitch(value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
                height: 1,
                color: Colors.black12,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 16, bottom: 20),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Setup Your Default Hour",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "   Start Time",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () => controller.getTimeFromUser("start"),
                            child: Container(
                              // width: MediaQuery.of(context).size.width * 0.4,
                              height: 50,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(width: 1)),
                              child: Obx(() => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(controller.startTime.value),
                                      Icon(
                                        Icons.access_time,
                                        color: Colors.amber,
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "   End Time",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () => controller.getTimeFromUser("end"),
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(width: 1)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.endTime.value),
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.amber,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

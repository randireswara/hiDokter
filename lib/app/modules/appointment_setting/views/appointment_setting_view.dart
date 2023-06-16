import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/appointment_setting_controller.dart';

class AppointmentSettingView extends GetView<AppointmentSettingController> {
  const AppointmentSettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> days = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Appointment Setting',
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
              onTap: () {
                String first = controller.selectedDay.value;
                String end = controller.selectedDay2.value;
                String hariBuka = "$first - $end";
                controller.sendDataToDb(
                    Get.arguments,
                    controller.switchValue.value,
                    controller.startTime.value,
                    controller.endTime.value,
                    hariBuka);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 10, top: 5),
                child: Icon(
                  Icons.save,
                  color: Colors.black,
                ),
              ))
        ],
      ),
      body: Column(
        children: [
          Obx(
            () => SizedBox(
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
                            "Your Status Will be change after 7 days",
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
          ),
          const SizedBox(
            height: 20,
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
                          child: Obx(() => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.endTime.value),
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
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "   Hari Buka",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => DropdownButton(
                          value: controller.selectedDay.value,
                          onChanged: (String? value) {
                            controller.changeDay(
                                value); //mengambil nilai index berdasarkan urutan list
                          },
                          items: days.map((String value) {
                            return DropdownMenuItem(
                              //tampilan isi data dropdown
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                        )),
                    const SizedBox(
                      width: 30,
                    ),
                    Text("buka Sampai"),
                    const SizedBox(
                      width: 30,
                    ),
                    Obx(() => DropdownButton(
                          value: controller.selectedDay2.value,
                          onChanged: (String? value) {
                            controller.changeDay2(
                                value); //mengambil nilai index berdasarkan urutan list
                          },
                          items: days.map((String value) {
                            return DropdownMenuItem(
                              //tampilan isi data dropdown
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

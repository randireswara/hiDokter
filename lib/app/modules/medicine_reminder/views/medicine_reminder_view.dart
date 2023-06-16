import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_dokter/app/database/authentication/authentication_repository.dart';
import 'package:hi_dokter/app/routes/app_pages.dart';

import 'package:intl/intl.dart';

import '../controllers/medicine_reminder_controller.dart';

class MedicineReminderView extends GetView<MedicineReminderController> {
  const MedicineReminderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Medicine Reminder',
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
      body: Column(
        children: [
          const AddTaskBar(),
          const SizedBox(
            height: 15,
          ),
          _addDateBar(),
          const SizedBox(
            height: 15,
          ),
          const TaskBar2()
          // _showTasks()
        ],
      ),
    );
  }
}

class AddTaskBar extends StatelessWidget {
  const AddTaskBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MedicineReminderController());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Text(
                    DateFormat.yMMMd().format(controller.selectedDate.value),
                    style: Theme.of(context).textTheme.displaySmall,
                  )),
              Text(
                "Today",
                style: Theme.of(context).textTheme.headlineSmall,
              )
            ],
          ),
          ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> task = {
                  'id': 1,
                  'drugName': "tes",
                  'longDay': "2",
                  'startDay': "senin",
                  'isCompleted': "isCompleted"
                };

                Get.toNamed(Routes.ADD_REMINDER);
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20)),
              child: const Text("+ add reminder"))
        ],
      ),
    );
  }
}

_addDateBar() {
  final controller = Get.put(MedicineReminderController());
  return Container(
    margin: const EdgeInsets.only(top: 20, left: 10),
    child: DatePicker(
      DateTime.now(),
      daysCount: 7,
      height: 100,
      width: 80,
      initialSelectedDate: DateTime.now(),
      selectionColor: Colors.black87,
      selectedTextColor: Colors.white,
      dateTextStyle: GoogleFonts.lato(
        textStyle: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
      ),
      dayTextStyle: GoogleFonts.lato(
        textStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
      ),
      monthTextStyle: GoogleFonts.lato(
        textStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
      ),
      onDateChange: (selectedDate) {
        controller.selected(selectedDate);
        controller.refreshData();
      },
    ),
  );
}

class TaskBar extends StatelessWidget {
  const TaskBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MedicineReminderController());
    final repo = Get.put(AuthenticationRepository());

    return Obx(() {
      var selected = DateFormat.yMd().format(controller.selectedDate.value);
      print(selected);
      return Expanded(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.getData(repo.userModel.value.email),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var myData = snapshot.data!.docs;
                  return ListView.builder(
                      itemCount: myData.length,
                      itemBuilder: (context, index) {
                        var startDay =
                            DateTime.parse(myData[index]["startDay"]);
                        var startDay2 = DateFormat.yMd().format(startDay);
                        print("start day ");

                        // var selectedDay = print("selected Day ");
                        if (DateFormat.yMd()
                                .format(controller.selectedDate.value) ==
                            startDay2) {
                          Map<String, dynamic> task = {
                            'id': index,
                            'drugName': myData[index]["drugName"],
                            'longDay': myData[index]["longDay"],
                            'startDay': myData[index]["startDay"],
                            'isCompleted': myData[index]["isCompleted"]
                          };
                          List dataWaktu = myData[index]["hour"];

                          for (var hour in dataWaktu) {
                            DateTime date = DateFormat.jm().parse(hour);

                            var myTime = DateFormat("HH:mm").format(date);

                            controller.service.scheduledNotification(
                                int.parse(myTime.toString().split(":")[0]),
                                int.parse(myTime.toString().split(":")[1]),
                                task);
                          }

                          return AnimationConfiguration.staggeredList(
                              position: index,
                              child: SlideAnimation(
                                child: FadeInAnimation(
                                    child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _showBottomSheet(context, task);
                                      },
                                      child: TaskTile(
                                        task: task,
                                      ),
                                    )
                                  ],
                                )),
                              ));
                        }
                      });
                }
                return Obx(() => Center(
                      child:
                          Text(controller.selectedDate.value.toIso8601String()),
                    ));
              }));
    });
  }
}

class TaskBar2 extends StatelessWidget {
  const TaskBar2({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MedicineReminderController());
    final repo = Get.put(AuthenticationRepository());
    return Obx(() {
      var selected = DateFormat.yMd().format(controller.selectedDate.value);
      print(selected);

      return Expanded(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.getData(repo.userModel.value.email),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              var myData = snapshot.data!.docs;
              return ListView.builder(
                itemCount: myData.length,
                itemBuilder: (context, index) {
                  var startDay = DateTime.parse(myData[index]["startDay"]);
                  var dateRange = List.generate(
                      int.parse(myData[index]["longDay"]),
                      (i) => startDay.add(Duration(days: i)));
                  var dateRangeFormatted = dateRange
                      .map((date) => DateFormat.yMd().format(date))
                      .toList();
                  print("date range $dateRangeFormatted");

                  if (dateRangeFormatted.contains(selected)) {
                    Map<String, dynamic> task = {
                      'id': index,
                      'drugName': myData[index]["drugName"],
                      'longDay': myData[index]["longDay"],
                      'startDay': myData[index]["startDay"],
                      'isCompleted': myData[index]["isCompleted"],
                      'idTask': myData[index].id
                    };
                    List dataWaktu = myData[index]["hour"];

                    for (var hour in dataWaktu) {
                      DateTime date = DateFormat.jm().parse(hour);
                      var myTime = DateFormat("HH:mm").format(date);

                      controller.service.scheduledNotification(
                          int.parse(myTime.toString().split(":")[0]),
                          int.parse(myTime.toString().split(":")[1]),
                          task);
                    }

                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showBottomSheet(context, task);
                                },
                                child: TaskTile(
                                  task: task,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              );
            }
            return SizedBox.shrink();
          },
        ),
      );
    });
  }
}

_showBottomSheet(BuildContext context, Map task) {
  final controller = Get.put(MedicineReminderController());
  final repo = Get.put(AuthenticationRepository());
  Get.bottomSheet(Container(
    padding: const EdgeInsets.only(top: 4),
    height: MediaQuery.of(context).size.height * 0.24,
    color: Get.isDarkMode ? Colors.grey : Colors.white,
    child: Column(
      children: [
        Container(
          height: 6,
          width: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
        ),
        const Spacer(),
        _bottomSheetButton(
            label: "Delete Task",
            onTap: () {
              // _taskController.delete(task);
              controller.deleteTask(repo.userModel.value.email, task["idTask"]);
              Get.back();
            },
            clr: Colors.red[300]!,
            context: context),
        const SizedBox(
          height: 20,
        ),
        _bottomSheetButton(
            label: "Close",
            onTap: () {
              navigator?.pop(context);
            },
            clr: Colors.white,
            context: context),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
  ));
}

_bottomSheetButton(
    {required String label,
    required Function()? onTap,
    required Color clr,
    required BuildContext context}) {
  return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          height: MediaQuery.of(context).size.width * 0.10,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.grey[300]!),
            color: clr,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              label,
            ),
          )));
}

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});
  final Map task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.amber),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task["drugName"],
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[800],
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${task["longDay"]} Hari",
                      style: GoogleFonts.lato(
                        textStyle:
                            const TextStyle(fontSize: 13, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  DateFormat.yMd().format(DateTime.parse(task["startDay"])),
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 15, color: Colors.grey[800]),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task["isCompleted"] == 1 ? "COMPLETED" : "TODO",
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

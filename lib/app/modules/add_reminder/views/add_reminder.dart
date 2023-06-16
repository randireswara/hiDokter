import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_dokter/app/database/authentication/authentication_repository.dart';
import 'package:hi_dokter/app/modules/add_reminder/controllers/add_reminder_controller.dart';
import 'package:intl/intl.dart';

class AddReminder extends StatelessWidget {
  const AddReminder({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Reminder',
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
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async => !await navigatorKey.currentState!.maybePop(),
          child: Navigator(
            key: navigatorKey,
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case '/':
                  return MaterialPageRoute(builder: (context) => Page1());

                case '/step1':
                  return MaterialPageRoute(builder: (context) => FormStep1());

                case '/step2':
                  return MaterialPageRoute(builder: (context) => FormStep2());
              }
            },
          ),
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  Page1({super.key});
  final controller = Get.put(AddReminderController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          header(context),
          const SizedBox(
            height: 40,
          ),
          Form(
            child: Column(
              children: [
                TextFormField(
                  controller: controller.namaObat,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    label: const Text("Drug Name"),
                    prefixIcon: const Image(
                      image: AssetImage("assets/images/pils.png"),
                      width: 15,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(
                          color: Colors.yellow,
                          width: 2,
                        )),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: controller.lamaHari,
                  decoration: InputDecoration(
                    label: const Text("How Long"),
                    prefixIcon: const Icon(Icons.calendar_today_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(
                          color: Colors.yellow,
                          width: 2,
                        )),
                    suffixText: "Days",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 20,
                ),

                // Obx(
                //   () => Column(
                //     children: [
                //       Container(
                //         margin: const EdgeInsets.only(bottom: 10),
                //         decoration: BoxDecoration(
                //             border: Border.all(color: Colors.grey),
                //             color: Colors.amber,
                //             borderRadius: BorderRadius.circular(20)),
                //         child: RadioListTile(
                //           title: const Text('1 x'),
                //           activeColor: Colors.black,
                //           value: 1,
                //           groupValue: controller.pilihanRadio.value,
                //           onChanged: (value) {
                //             controller.setSelectedValue(value!);
                //           },
                //         ),
                //       ),
                //       Container(
                //         margin: const EdgeInsets.only(bottom: 10),
                //         decoration: BoxDecoration(
                //             border: Border.all(color: Colors.grey),
                //             color: Colors.amber,
                //             borderRadius: BorderRadius.circular(20)),
                //         child: RadioListTile(
                //           title: const Text('2 x'),
                //           activeColor: Colors.black,
                //           value: 2,
                //           groupValue: controller.pilihanRadio.value,
                //           onChanged: (value) {
                //             controller.setSelectedValue(value!);
                //           },
                //         ),
                //       ),
                //       Container(
                //         margin: const EdgeInsets.only(bottom: 10),
                //         decoration: BoxDecoration(
                //             border: Border.all(color: Colors.grey),
                //             color: Colors.amber,
                //             borderRadius: BorderRadius.circular(20)),
                //         child: RadioListTile(
                //           title: const Text('3 x'),
                //           activeColor: Colors.black,
                //           value: 3,
                //           groupValue: controller.pilihanRadio.value,
                //           onChanged: (value) {
                //             controller.setSelectedValue(value!);
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                Calendar(),
                const SizedBox(
                  height: 20,
                ),
                HourMethod(controller: controller),
                const Button(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Calendar extends StatelessWidget {
  Calendar({
    super.key,
  });
  final controller = Get.put(AddReminderController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Start From?',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 52,
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(children: [
            Obx(
              () => Expanded(
                child: TextFormField(
                  readOnly: false,
                  autofocus: false,
                  cursorColor:
                      Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                  autocorrect: false,
                  //  controller: controller,

                  decoration: InputDecoration(
                    hintText: DateFormat.yMMMd()
                        .format(controller.selectedDate.value),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: context.theme.colorScheme.background,
                      width: 0,
                    )),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: context.theme.colorScheme.background,
                        width: 0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.calendar_month),
              onPressed: () {
                controller.getDateFromUser(context);
              },
            )
          ]),
        )
      ],
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddReminderController());
    final repo = Get.put(AuthenticationRepository());
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Obx(() => SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(16), // Mengatur border radius
                ),
                backgroundColor:
                    Colors.black87, // Mengatur warna latar belakang
              ),
              onPressed: () async {
                // ignore: unnecessary_null_comparison
                if (controller.namaObat.text.isNotEmpty &&
                    controller.lamaHari.text.isNotEmpty) {
                  print(controller.reminderTimes);
                  controller.sendData(
                    repo.userModel.value.email!,
                    controller.namaObat.text,
                    controller.lamaHari.text,
                    controller.pilihanRadio.value,
                    controller.reminderTimes,
                    controller.selectedDate.value.toString(),
                  );
                  Get.snackbar("success", "your reminder has been updated",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.white,
                      icon: const Icon(Icons.checklist_rounded));
                  controller.namaObat.clear();
                  controller.lamaHari.clear();
                } else if (controller.namaObat.text.isEmpty ||
                    controller.lamaHari.text.isEmpty) {
                  print("tesMasuk 2");
                  Get.snackbar("Required", "All field are required",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.white,
                      icon: const Icon(Icons.warning_amber_rounded));
                }
              },
              child: controller.loading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Text(
                      'Finish',
                      style:
                          TextStyle(color: Colors.white), // Mengatur warna teks
                    ),
            ),
          )),
    );
  }
}

header(context) {
  return Column(
    children: [
      Text(
        "Fill in Information About Drugs ",
        style: Theme.of(context).textTheme.headlineSmall,
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        "Fill in the drug information to remind you to take the drug",
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
    ],
  );
}

class HourMethod extends StatelessWidget {
  HourMethod({
    super.key,
    required this.controller,
  });

  final dateNow = DateFormat("hh:mm a").format(DateTime.now()).toString();

  final AddReminderController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Reminder Hour",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: 52,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(children: [
                  Obx(
                    () => Expanded(
                      child: TextFormField(
                        readOnly: true,
                        autofocus: false,
                        cursorColor: Get.isDarkMode
                            ? Colors.grey[100]
                            : Colors.grey[700],
                        autocorrect: false,
                        decoration: InputDecoration(
                          // ignore: unnecessary_null_comparison
                          hintText: controller.reminderTimes.isEmpty
                              ? dateNow
                              : "${controller.reminderTimes[index]}",
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: context.theme.colorScheme.background,
                            width: 0,
                          )),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: context.theme.colorScheme.background,
                              width: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: const Icon(Icons.access_time_rounded),
                        onPressed: () {
                          controller.getTimeFromUser(index, context);
                        },
                      );
                    },
                  )
                ]),
              )
            ],
          ),
        );
      },
    );
  }
}

class FormStep1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('FormStep1'),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/step2'),
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}

class FormStep2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('FormStep2'),
          ElevatedButton(onPressed: () {}, child: Text('Next')),
        ],
      ),
    );
  }
}

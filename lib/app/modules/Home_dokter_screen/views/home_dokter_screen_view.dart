import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hi_dokter/app/database/authentication/authentication_repository.dart';
import 'package:hi_dokter/app/modules/chat_dokter/views/chat_dokter_view.dart';
import 'package:hi_dokter/app/modules/history_patient/controllers/history_patient_controller.dart';
import 'package:hi_dokter/app/modules/list_chat_for_pasien/views/chat_pasien_view.dart';
import 'package:hi_dokter/app/modules/history_patient/views/history_patient_view.dart';

import 'package:hi_dokter/app/modules/notification_page/views/notification_page_view.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';

import '../controllers/home_dokter_screen_controller.dart';

class HomeDokterScreenView extends GetView<HomeDokterScreenController> {
  HomeDokterScreenView({Key? key}) : super(key: key);

  final List<Widget> screens = [
    const HomeBar(),
    const NotificationPageView(),
    const HistoryPatientView(),
    const ChatDokterView(),
  ];

  @override
  Widget build(BuildContext context) {
    final repo = Get.put(AuthenticationRepository());
    return Scaffold(
        body: Obx(() => screens[controller.selectedIndex.value]),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: controller
                        .unreadNotification(repo.userModel.value.email),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        var cekData = snapshot.data!.docs;
                        print(cekData);

                        if (cekData.isEmpty) {
                          return const Icon(Icons.notification_important);
                        } else if (cekData.isNotEmpty) {
                          return Stack(
                            children: [
                              Icon(Icons.notification_important),
                              Positioned(
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 16,
                                    minHeight: 16,
                                  ),
                                  child: const Text(
                                    '0', // Jumlah chat yang belum terbaca
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      }
                      return const Icon(Icons.notification_important);
                    }),
                label: 'Notification',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history_outlined),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat',
              )
            ],
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: Colors.amber,
            unselectedItemColor: Colors.black,
            onTap: controller.onItemTapped,
          ),
        ));
  }
}

class HomeBar extends StatelessWidget {
  const HomeBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(),
          SizedBox(
            height: 20,
          ),
          Divider(
            thickness: 1,
            color: Colors.black,
            height: 1,
          ),
          SizedBox(
            height: 20,
          ),
          Footer(),
          SizedBox(
            height: 20,
          ),
          Text("Appointment Today",
              style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(
            height: 10,
          ),
          AppointmentTodayDoctor()
        ],
        //
      ),
    );
  }
}

class AppointmentTodayDoctor extends StatelessWidget {
  const AppointmentTodayDoctor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeDokterScreenController());
    final controller2 = Get.put(HistoryPatientController());
    final repo = Get.put(AuthenticationRepository());
    String date = DateFormat.yMd().format(DateTime.now());
    print(date);
    return Expanded(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream:
              controller.streamAppointment(repo.userModel.value.email, date),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              var myData = snapshot.data!.docs;
              if (myData.isEmpty) {
                return Container();
              }

              return ListView.builder(
                itemCount: myData.length,
                itemBuilder: (context, index) {
                  String day = DateFormat('EEEE, d MMMM yyyy').format(
                      DateFormat('d/M/yyyy').parse(myData[index]['day']));
                  return SizedBox(
                    width: double.infinity,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              FutureBuilder<String>(
                                  future: controller
                                      .getPhoto(myData[index]['emailPasien']),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      var myData2 = snapshot.data;
                                      print("foto $myData");
                                      if (myData2 != null) {
                                        return CircleAvatar(
                                          radius: 20,
                                          backgroundColor: const Color.fromARGB(
                                              255, 255, 229, 229),
                                          foregroundColor: Colors.black38,
                                          backgroundImage: NetworkImage(
                                              myData2), // ganti dengan path gambar lokal Anda
                                        );
                                      }
                                      return const CircleAvatar(
                                        radius: 20,
                                        backgroundColor:
                                            Color.fromARGB(255, 255, 229, 229),
                                        foregroundColor: Colors.black38,
                                        backgroundImage:
                                            null, // ganti dengan path gambar lokal Anda
                                      );
                                    }
                                    return const CircleAvatar(
                                      radius: 20,
                                      backgroundColor:
                                          Color.fromARGB(255, 255, 229, 229),
                                      foregroundColor: Colors.black38,
                                      backgroundImage:
                                          null, // ganti dengan path gambar lokal Anda
                                    );
                                  }),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    myData[index]["namaPasien"],
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    "Today Schedule",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.black),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      color: Colors.amber,
                                    ),
                                    Text(day)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: Colors.amber,
                                    ),
                                    Text(myData[index]["hour"]),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('confirm'),
                                          content: Text(
                                              'are you sure want to finish appointment'),
                                          actions: [
                                            TextButton(
                                              child: Text('no'),
                                              onPressed: () {
                                                Navigator.of(context).pop(
                                                    false); // respons tidak
                                              },
                                            ),
                                            TextButton(
                                              child: Text('yes'),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(true); // respons ya
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ).then((response) {
                                      if (response != null &&
                                          response == true) {
                                        // lakukan tugas jika respons ya
                                        controller2
                                            .completeTask(
                                                myData[index].id,
                                                repo.userModel.value.email,
                                                myData[index]["emailPasien"],
                                                repo.userModel.value.fullName)
                                            .then((_) => Get.snackbar(
                                                "congratulation doctor",
                                                "your appointment is completed"));
                                      }
                                    });
                                  },
                                  child: Text("Completed")))
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          }),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthenticationRepository());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Setup Your App,Doctor",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(
          height: 20,
        ),
        ToFiture(
          title: "Setting Chat",
          image: const Icon(Icons.chat_rounded),
          onTap: () {
            Get.toNamed(Routes.CHAT_SETTING_DR,
                arguments: controller.userModel.value.email);
          },
          color: const Color.fromARGB(255, 255, 233, 233),
        ),
        const SizedBox(
          height: 15,
        ),
        ToFiture(
          title: "Setting Appointment",
          image: const Icon(Icons.calendar_month),
          onTap: () => Get.toNamed(Routes.APPOINTMENT_SETTING,
              arguments: controller.userModel.value.email),
          color: const Color.fromARGB(255, 244, 210, 255),
        ),
      ],
    );
  }
}

class ToFiture extends StatelessWidget {
  const ToFiture(
      {super.key,
      required this.image,
      required this.title,
      required this.color,
      required this.onTap});

  final String title;
  final Widget image;
  final Function()? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  color: color),
              child: image,
            ),
            Expanded(
              child: Container(
                height: 70,
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: color,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 30.0),
                      height: 30,
                      width: 30,
                      child: const Icon(Icons.arrow_forward_ios_rounded),
                    )
                  ],
                ),
              ),
            )
          ],
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
    final controller = Get.put(AuthenticationRepository());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text(
                  "Hi ${controller.userModel.value.fullName} ",
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
            Text(
              "Your Patience is waiting for you",
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
        Obx(() => GestureDetector(
              onTap: () => Get.toNamed(Routes.PROFILE_DOCTOR),
              child: CachedNetworkImage(
                imageUrl: controller.userModel.value.photoUrl!,
                imageBuilder: (context, imageProvider) => Hero(
                  tag: 'imageHero',
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Color.fromARGB(255, 255, 229, 229),
                    foregroundColor: Colors.black38,
                    backgroundImage:
                        imageProvider, // ganti dengan path gambar lokal Anda
                  ),
                ),
                placeholder: (context, url) => const Hero(
                  tag: 'imageHero',
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Color.fromARGB(255, 255, 229, 229),
                    foregroundColor: Colors.black38,
                    backgroundImage: AssetImage(
                        'assets/images/nopicture.jpg'), // ganti dengan path gambar lokal Anda
                  ),
                ),
                errorWidget: (context, url, error) => const Hero(
                  tag: 'imageHero',
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Color.fromARGB(255, 255, 229, 229),
                    foregroundColor: Colors.black38,
                    backgroundImage: AssetImage(
                        'assets/images/nopicture.jpg'), // ganti dengan path gambar lokal Anda
                  ),
                ),
              ),
            ))
      ],
    );
  }
}

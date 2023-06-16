import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_dokter/app/database/authentication/authentication_repository.dart';

import 'package:hi_dokter/app/modules/history_order/views/history_order_view.dart';
import 'package:hi_dokter/app/modules/kritik_dan_saran/views/kritik_dan_saran_view.dart';
import 'package:hi_dokter/app/modules/notification_page/views/notification_page_view.dart';

import 'package:hi_dokter/app/routes/app_pages.dart';

import '../../chat_dokter/views/chat_dokter_view.dart';
import '../../list_chat_for_pasien/views/chat_pasien_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  final List<Widget> screens = const [
    HomeBar(),
    NotificationPageView(),
    HistoryOrderView(),
    ChatPasienView(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
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
                label: 'History',
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
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.only(top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(),
            SizedBox(
              height: 20,
            ),
            News(),
            SizedBox(
              height: 20,
            ),
            Footer()
          ],
          //
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Health Care",
          style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
        const SizedBox(
          height: 20,
        ),
        ToFiture(
          title: "Consultation",
          image: const Image(image: AssetImage("assets/images/icon_steto.png")),
          onTap: () {
            Get.toNamed(Routes.PILIH_KONSULTASI);
          },
          color: const Color.fromARGB(255, 254, 229, 156),
        ),
        const SizedBox(
          height: 15,
        ),
        ToFiture(
          title: "Medicine Reminder",
          image: const Icon(Icons.calendar_month),
          onTap: () {
            Get.toNamed(Routes.MEDICINE_REMINDER);
          },
          color: const Color.fromARGB(255, 255, 233, 233),
        ),
        const SizedBox(
          height: 15,
        ),
        ToFiture(
          title: "Covid 19",
          image: const Icon(Icons.coronavirus_rounded),
          onTap: () => Get.toNamed(Routes.COVID_19),
          color: const Color.fromARGB(255, 244, 210, 255),
        ),
        const SizedBox(
          height: 15,
        ),
        ToFiture(
          title: "Kritik dan saran",
          image: const Icon(Icons.chat_rounded),
          onTap: () {
            Get.to(() => const FeedbackPage());
          },
          color: Color.fromARGB(255, 240, 224, 246),
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
        width: double.infinity,
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
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black),
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

class News extends StatelessWidget {
  const News({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return SizedBox(
        height: 200,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.newsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                var myData = snapshot.data!.docs;
                if (myData.isEmpty) {
                  return Container();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: myData.length,
                  itemBuilder: (BuildContext context, index) {
                    Map<String, dynamic> arguments = {
                      'title': myData[index]["title"],
                      'content': myData[index]["content"],
                      'createdAt': myData[index]["createdAt"],
                      'writer': myData[index]["writer"],
                      'theme': myData[index]["newsTheme"],
                      'news': myData[index]["photoUrl"]
                    };

                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL_NEWS, arguments: arguments);
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 240,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, top: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 255, 237, 190),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        myData[index]["title"],
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Flexible(
                                      child: Image(
                                        image: AssetImage(
                                            "assets/images/intro_1.png"),
                                        width: 300,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                      ),
                                      Text(
                                        "Learn More ->",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return SizedBox(
                  width: 320,
                  height: 240,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 255, 237, 190),
                      ),
                    ),
                  ));
            }));
  }
}

class Header extends StatelessWidget {
  Header({
    super.key,
  });
  final controller = Get.put(AuthenticationRepository());
  final controller2 = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller2.homeStream(controller.userModel.value.email!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var myData = snapshot.data?.data();
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi ${myData!["fullName"]}",
                        style: Theme.of(context).textTheme.headlineSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "How Are You Feeling Today?",
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    ],
                  ),
                ),
                Obx(() => GestureDetector(
                      onTap: () => Get.toNamed(Routes.MY_PROFILE),
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
          return const Center(child: CircularProgressIndicator());
        });
  }
}

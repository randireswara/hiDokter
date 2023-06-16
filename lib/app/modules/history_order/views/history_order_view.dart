import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hi_dokter/app/database/authentication/authentication_repository.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../controllers/history_order_controller.dart';

class HistoryOrderView extends StatefulWidget {
  const HistoryOrderView({super.key});

  @override
  HistoryOrderViewState createState() => HistoryOrderViewState();
}

class HistoryOrderViewState extends State<HistoryOrderView> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    UpcomingScheduleScreen(),
    CompletedScheduleScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Appointment Schedule',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.left,
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  child: Container(
                    decoration: _selectedIndex == 0
                        ? BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(20))
                        : const BoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15),
                      child: Text(
                        'Upcoming',
                        style: TextStyle(
                          color:
                              _selectedIndex == 0 ? Colors.white : Colors.grey,
                          fontWeight: _selectedIndex == 0
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  child: Container(
                    decoration: _selectedIndex == 1
                        ? BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(20))
                        : const BoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: Text(
                        'Complete',
                        style: TextStyle(
                          color:
                              _selectedIndex == 1 ? Colors.white : Colors.grey,
                          fontWeight: _selectedIndex == 1
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class UpcomingScheduleScreen extends StatelessWidget {
  UpcomingScheduleScreen({super.key});

  String formattedTime = DateFormat('h:mm a').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HistoryOrderController());
    final repo = Get.put(AuthenticationRepository());
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.getDataUpcoming(repo.userModel.value.email),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                var myData = snapshot.data!.docs;
                if (myData.isEmpty) {
                  return SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          Lottie.asset("assets/lottie/empty.json"),
                          Text(
                            "empty data",
                            style: Theme.of(context).textTheme.displaySmall,
                          )
                        ],
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: myData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                FutureBuilder<String>(
                                    future: controller
                                        .getPhoto(myData[index]['emailDokter']),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        var myData = snapshot.data;
                                        print("foto $myData");
                                        if (myData != null) {
                                          return CircleAvatar(
                                            radius: 25,
                                            backgroundImage:
                                                NetworkImage(myData),
                                          );
                                        }
                                        return const CircleAvatar(
                                          radius: 25,
                                          backgroundImage: null,
                                        );
                                      }
                                      return const CircleAvatar(
                                        radius: 25,
                                        backgroundImage: null,
                                      );
                                    }),
                                FutureBuilder<Map>(
                                    future: controller.getNameAndSpesialis(
                                        myData[index]["emailDokter"]),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        var name = snapshot.data;

                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                name!["name"],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                name["spesialis"],
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                      return Container();
                                    })
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      size: 15,
                                      color: Colors.grey[700],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      myData[index]["day"],
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 15,
                                      color: Colors.grey[500],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      myData[index]["hour"],
                                      style: TextStyle(color: Colors.grey[500]),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('confirm'),
                                              content: const Text(
                                                  'Are you sure want to cancel appointment'),
                                              actions: [
                                                TextButton(
                                                  child: Text('cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop(
                                                        false); // respons tidak
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text('yes'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop(
                                                        true); // respons ya
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        ).then((response) {
                                          if (response != null &&
                                              response == true) {
                                            // lakukan tugas jika respons ya
                                            controller
                                                .deleteTask(
                                                    myData[index].id,
                                                    repo.userModel.value.email,
                                                    myData[index]
                                                        ["emailDokter"])
                                                .then((_) => Get.snackbar(
                                                    "success",
                                                    "success delete appointment"))
                                                .then((value) => print(value));
                                          }
                                        });
                                      },
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                              color: Colors.black54)),
                                      child: Text("Cancel")),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Container();
            }),
      ),
    );
  }
}

// ignore: must_be_immutable
class CompletedScheduleScreen extends StatelessWidget {
  CompletedScheduleScreen({super.key});

  String formattedTime = DateFormat('h:mm a').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HistoryOrderController());
    final repo = Get.put(AuthenticationRepository());
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.getDataCompleted(repo.userModel.value.email),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                var myData = snapshot.data!.docs;
                if (myData.isEmpty) {
                  return SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          Lottie.asset("assets/lottie/empty.json"),
                          Text(
                            "empty data",
                            style: Theme.of(context).textTheme.displaySmall,
                          )
                        ],
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: myData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                FutureBuilder<String>(
                                    future: controller
                                        .getPhoto(myData[index]['emailDokter']),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        var myData2 = snapshot.data;
                                        print("foto $myData");
                                        if (myData2 != null) {
                                          return CircleAvatar(
                                            radius: 25,
                                            backgroundImage:
                                                NetworkImage(myData2),
                                          );
                                        }
                                        return const CircleAvatar(
                                          radius: 25,
                                          backgroundImage: null,
                                        );
                                      }
                                      return const CircleAvatar(
                                        radius: 25,
                                        backgroundImage: null,
                                      );
                                    }),
                                FutureBuilder<Map>(
                                    future: controller.getNameAndSpesialis(
                                        myData[index]["emailDokter"]),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        var name = snapshot.data;

                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                name!["name"],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                name["spesialis"],
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                      return Container();
                                    })
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      size: 15,
                                      color: Colors.grey[700],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      myData[index]["day"],
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 15,
                                      color: Colors.grey[500],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      myData[index]["hour"],
                                      style: TextStyle(color: Colors.grey[500]),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Container();
            }),
      ),
    );
  }
}

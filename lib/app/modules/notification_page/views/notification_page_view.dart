import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hi_dokter/app/database/authentication/authentication_repository.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../controllers/notification_page_controller.dart';

class NotificationPageView extends GetView<NotificationPageController> {
  const NotificationPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final repo = Get.put(AuthenticationRepository());
    final controller = Get.put(NotificationPageController());
    controller.readNotification(repo.userModel.value.email);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notification',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.left,
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.streamNotification(repo.userModel.value.email),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                var myData = snapshot.data!.docs;
                print(repo.userModel.value.email);

                if (myData.isEmpty) {
                  print("myData $myData");
                  return Center(
                    child: Column(
                      children: [
                        const Spacer(),
                        Lottie.asset("assets/lottie/empty.json"),
                        const Spacer()
                        // Text(
                        //   "empty data",
                        //   style: Theme.of(context).textTheme.displaySmall,)
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: myData.length,
                  itemBuilder: (context, index) {
                    print(myData[index]["createdAT"]);
                    // print(DateFormat.yMd()
                    //     .format(DateTime.parse(myData[index]["createdAT"])));

                    return Card(
                      color: Colors.grey[100],
                      elevation: 2.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        title: Text(
                          myData[index]["title"],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          myData[index]["subtitle"],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(DateFormat.yMd()
                              .format(
                                  DateTime.parse(myData[index]["createdAT"]))
                              .toString()),
                        ),
                        onTap: () {
                          // Do something when the notification is tapped
                        },
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

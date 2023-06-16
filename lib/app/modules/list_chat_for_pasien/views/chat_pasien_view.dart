import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hi_dokter/app/database/authentication/authentication_repository.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../controllers/chat_pasien_controller.dart';

class ChatPasienView extends GetView<ChatPasienController> {
  const ChatPasienView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatPasienController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat Doctor',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.left,
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SearchBar(controller: controller.search),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 20.0),
            child: Text(
              "Available Doctor",
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          const DaftarChat()
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(Icons.search),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none),
            ),
          ),
          IconButton(
            onPressed: () {
              controller.clear();
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
    );
  }
}

class DaftarChat extends StatelessWidget {
  const DaftarChat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatPasienController());
    final repo = Get.put(AuthenticationRepository());
    return Obx(() {
      var searchBar = controller.tempSearch.value;
      return Expanded(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.streamDataDokter(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                var dataDokterOnline = snapshot.data!.docs;
                final filteredData = dataDokterOnline.where((doc) {
                  final name = doc['fullName'];
                  return name.toLowerCase().contains(searchBar);
                }).toList();
                if (dataDokterOnline.isEmpty) {
                  return Center(
                    child: Lottie.asset("assets/lottie/empty.json"),
                  );
                }

                return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      print("ada dokter online");
                      return StreamBuilder<Map<dynamic, dynamic>>(
                          stream: controller.getUnreadAndHour2(
                              repo.userModel.value.email!,
                              filteredData[index]["email"]),
                          //tambahkan cek apakah ada data antara mereka jika tidak ada tidak usah dicari
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done ||
                                snapshot.connectionState ==
                                    ConnectionState.active) {
                              var myData2 = snapshot.data;

                              if (myData2!.isEmpty) {
                                String jamBuka = filteredData[index]["jamBuka"];
                                String jamTutup =
                                    filteredData[index]["jamTutup"];
                                String waktu = '$jamBuka - $jamTutup';
                                return InkWell(
                                  onTap: () {
                                    controller.goToChatRoom(
                                        repo.userModel.value.email!,
                                        filteredData[index]["email"],
                                        filteredData[index]["fullName"],
                                        repo.userModel.value.fullName!,
                                        filteredData[index]["photoUrl"]);
                                    // Get.toNamed(Routes.ROOM_CHAT, arguments: dataDokter);
                                  },
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.black26,
                                            child: CachedNetworkImage(
                                              imageUrl: filteredData[index]
                                                  ["photoUrl"],
                                              imageBuilder: (context,
                                                      imageProvider) =>
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              70),
                                                      child: Image(
                                                        image: imageProvider,
                                                        fit: BoxFit.fill,
                                                      )),
                                              placeholder: (context, url) =>
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              70),
                                                      child: const Image(
                                                        image: AssetImage(
                                                            "assets/images/nopicture.jpg"),
                                                        fit: BoxFit.fill,
                                                      )),
                                            )),
                                        title: Text(
                                          filteredData[index]["fullName"],
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        subtitle: Text(waktu),
                                      ),
                                      Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.grey[300],
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                print("mydataisnotempty");
                                String jamBuka = filteredData[index]["jamBuka"];
                                String jamTutup =
                                    filteredData[index]["jamTutup"];
                                String waktu = '$jamBuka - $jamTutup';
                                if (snapshot.data!["jam"] == null) {
                                  print("jika masuk room chat tapi belum chat");
                                  String jamBuka =
                                      filteredData[index]["jamBuka"];
                                  String jamTutup =
                                      filteredData[index]["jamTutup"];
                                  String waktu = '$jamBuka - $jamTutup';
                                  return InkWell(
                                    onTap: () {
                                      controller.goToChatRoom(
                                          repo.userModel.value.email!,
                                          filteredData[index]["email"],
                                          filteredData[index]["fullName"],
                                          repo.userModel.value.fullName!,
                                          filteredData[index]["photoUrl"]);
                                      // Get.toNamed(Routes.ROOM_CHAT, arguments: dataDokter);
                                    },
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Colors.black26,
                                              child: CachedNetworkImage(
                                                imageUrl: filteredData[index]
                                                    ["photoUrl"],
                                                imageBuilder: (context,
                                                        imageProvider) =>
                                                    ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(70),
                                                        child: Image(
                                                          image: imageProvider,
                                                          fit: BoxFit.fill,
                                                        )),
                                                placeholder: (context, url) =>
                                                    ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(70),
                                                        child: const Image(
                                                          image: AssetImage(
                                                              "assets/images/nopicture.jpg"),
                                                          fit: BoxFit.fill,
                                                        )),
                                              )),
                                          title: Text(
                                            filteredData[index]["fullName"],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          subtitle: Text(waktu),
                                        ),
                                        Divider(
                                          height: 1,
                                          thickness: 1,
                                          color: Colors.grey[300],
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  print("jika masuk room chat dan sudah chat");
                                  DateTime dateTime =
                                      DateTime.parse(snapshot.data!["jam"]);

                                  String formattedTime =
                                      DateFormat('HH:mm').format(dateTime);

                                  String jamBuka =
                                      filteredData[index]["jamBuka"];
                                  String jamTutup =
                                      filteredData[index]["jamTutup"];
                                  String waktu = '$jamBuka - $jamTutup';
                                  final unread = snapshot.data!['unread'];
                                  print(unread);
                                  return InkWell(
                                    onTap: () {
                                      controller.goToChatRoom(
                                          repo.userModel.value.email!,
                                          filteredData[index]["email"],
                                          filteredData[index]["fullName"],
                                          repo.userModel.value.fullName!,
                                          filteredData[index]["photoUrl"]);
                                    },
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.black26,
                                            child: CachedNetworkImage(
                                              imageUrl: filteredData[index]
                                                  ["photoUrl"],
                                              imageBuilder: (context,
                                                      imageProvider) =>
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              70),
                                                      child: Image(
                                                        image: imageProvider,
                                                        fit: BoxFit.fill,
                                                      )),
                                              placeholder: (context, url) =>
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              70),
                                                      child: const Image(
                                                        image: AssetImage(
                                                            "assets/images/nopicture.jpg"),
                                                        fit: BoxFit.fill,
                                                      )),
                                            ),
                                          ),
                                          title: Text(
                                            filteredData[index]["fullName"],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          subtitle: Text(waktu),
                                          trailing: Column(
                                            children: [
                                              Text(formattedTime),
                                              myData2["unread"] == 0
                                                  ? const SizedBox()
                                                  : Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      decoration:
                                                          const BoxDecoration(
                                                              color:
                                                                  Colors.grey,
                                                              shape: BoxShape
                                                                  .circle),
                                                      child: Text(
                                                          myData2["unread"]
                                                              .toString()),
                                                    )
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                          thickness: 1,
                                          color: Colors.grey[300],
                                        )
                                      ],
                                    ),
                                  );
                                }
                              }
                            }
                            return Container();
                          });
                    });
              }
              return Container();
            }),
      );
    });
  }
}

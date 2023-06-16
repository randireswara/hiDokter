import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hi_dokter/app/database/authentication/authentication_repository.dart';
import 'package:hi_dokter/app/routes/app_pages.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../controllers/chat_dokter_controller.dart';

class ChatDokterView extends GetView<ChatDokterController> {
  const ChatDokterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatDokterController());
    final repo = Get.put(AuthenticationRepository());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat With Patient',
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
            child: SearchBar(controller: controller.searchText),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 20.0),
            child: Text(
              "Available Patient",
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
    final controller2 = Get.put(ChatDokterController());
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
              // onEditingComplete: () => controller2.deleteSearch(),
              onChanged: (value) => controller2.searchFunc(value),
              controller: controller,
              decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none),
            ),
          ),
          IconButton(
            onPressed: () {
              controller2.deleteSearch();
              controller2.searchText.clear();
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
    final controller = Get.put(ChatDokterController());
    final repo = Get.put(AuthenticationRepository());

    return Obx(() {
      var searchBar = controller.search.value;
      print(searchBar);
      return Expanded(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.streamList(repo.userModel.value.email),
            builder: (context, snapshot) {
              print(snapshot.data);
              if (snapshot.connectionState == ConnectionState.active) {
                var myData = snapshot.data!.docs;

                final filteredData = myData.where((doc) {
                  final name = doc['namaPasien'];
                  return name.toLowerCase().contains(searchBar);
                }).toList();
                if (filteredData.isEmpty) {
                  return Container();
                }
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
                  padding: EdgeInsets.zero,
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    if (filteredData[index]["lastUpdate"] == null) {}
                    DateTime? lastUpdate =
                        filteredData[index]["lastUpdate"] != null
                            ? DateTime.parse(filteredData[index]["lastUpdate"])
                            : null;

                    String? formattedTime = lastUpdate != null
                        ? DateFormat('HH:mm').format(lastUpdate)
                        : "";
                    return StreamBuilder<Map<dynamic, dynamic>>(
                      stream: controller.getUnreadAndHour2(
                          filteredData[index].id,
                          filteredData[index]['emailPasien']),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else {
                          var myData2 = snapshot.data!["unread"];

                          return InkWell(
                            onTap: () {
                              controller.goToRoomChat(
                                  filteredData[index]['emailPasien'],
                                  repo.userModel.value.email!,
                                  filteredData[index].id,
                                  filteredData[index]['namaPasien']);
                            },
                            child: Column(
                              children: [
                                ListTile(
                                  leading: FutureBuilder<String>(
                                      future: controller.getPhoto(
                                          myData[index]['emailPasien']),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          var myData3 = snapshot.data;
                                          print("foto $myData");
                                          if (myData3 != null) {
                                            return CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.black26,
                                                child: CachedNetworkImage(
                                                  imageUrl: myData3,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(70),
                                                          child: Image(
                                                            image:
                                                                imageProvider,
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
                                                ));
                                          }
                                          return CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Colors.black26,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(70),
                                                  child: null));
                                        }
                                        return CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.black26,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(70),
                                                child: null));
                                      }),
                                  title: Text(
                                    filteredData[index]["namaPasien"],
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  trailing: Column(
                                    children: [
                                      Text(formattedTime),
                                      myData2 == 0
                                          ? const SizedBox()
                                          : Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: const BoxDecoration(
                                                  color: Colors.grey,
                                                  shape: BoxShape.circle),
                                              child: Text(myData2.toString()),
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
                      },
                    );
                  },
                );
              }
              return Container();
            }),
      );
    });
  }
}

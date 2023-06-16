import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hi_dokter/app/database/authentication/authentication_repository.dart';
import 'package:intl/intl.dart';

import '../controllers/room_chat_controller.dart';

class RoomChatView extends GetView<RoomChatController> {
  const RoomChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _chat(),
          _textField(),
        ],
      ),
    );
  }
}

_appBar() {
  final controller = Get.put(RoomChatController());
  return AppBar(
      backgroundColor: Colors.amber,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 15),
            child: FutureBuilder<String>(
                future: controller.getPhoto(controller.emailPenerima),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    var myData = snapshot.data;

                    if (myData != null) {
                      return CachedNetworkImage(
                        imageUrl: myData,
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(myData),
                          ),
                        ),
                        placeholder: (context, url) => CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(myData),
                          ),
                        ),
                      );
                    }
                    return CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: null,
                      ),
                    );
                  }
                  return const CircleAvatar(
                    radius: 25,
                    backgroundImage: null,
                  );
                }),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.namaPenerima,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 2,
              ),
              const Text(
                "Online",
                style: TextStyle(fontSize: 13, color: Colors.black),
              )
            ],
          ),
        ],
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: Colors.black87,
          size: 20,
        ),
        onPressed: () {
          Get.back();
        },
      ));
}

_textField() {
  final controller = Get.put(RoomChatController());
  final repo = Get.put(AuthenticationRepository());
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    width: Get.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
              child: TextField(
            onTap: () {
              controller.scroll();
            },
            textInputAction: TextInputAction.done,
            onSubmitted: (value) => controller.scroll(),
            controller: controller.textField,
            focusNode: controller.focusNode,
            autocorrect: false,
            onEditingComplete: () {
              Get.focusScope!.unfocus();
            },
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                prefixIcon: IconButton(
                    onPressed: () {
                      // controller.focusNode.unfocus();
                      // controller.isShowEmoji.toggle();
                    },
                    icon: const Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.grey,
                    )),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100))),
          )),
        ),
        const SizedBox(
          width: 5,
        ),
        InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            controller.sendData(
                controller.idChat,
                controller.textField.text.trim(),
                controller.emailPenerima,
                repo.userModel.value.email!,
                repo.userModel.value.fullName!);
          },
          child: const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.amber,
            child: Icon(
              Icons.send,
              size: 25,
            ),
          ),
        ),
      ],
    ),
  );
}

_chat() {
  final controller = Get.put(RoomChatController());

  return Expanded(
      child: Container(
    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.streamChat(controller.idChat),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var chatData = snapshot.data!.docs;
            Timer(
                Duration.zero,
                () => controller.scrollC
                    .jumpTo(controller.scrollC.position.maxScrollExtent));
            return ListView.builder(
                shrinkWrap: true,
                controller: controller.scrollC,
                itemCount: chatData.length,
                itemBuilder: (context, index) {
                  DateTime dateTime = DateTime.parse(chatData[index]["time"]);

                  String timeString = DateFormat('HH:mm').format(dateTime);
                  if (index == 0) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          chatData[index]["groupTime"],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ItemChat(
                          isSender: chatData[index]["penerima"] ==
                                  controller.emailPenerima
                              ? true
                              : false,
                          msg: "${chatData[index]["msg"]}",
                          time: timeString,
                        )
                      ],
                    );
                  } else {
                    if (chatData[index]["groupTime"] ==
                        chatData[index - 1]["groupTime"]) {
                      return ItemChat(
                        isSender: chatData[index]["penerima"] ==
                                controller.emailPenerima
                            ? true
                            : false,
                        msg: "${chatData[index]["msg"]}",
                        time: timeString,
                      );
                    } else {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            chatData[index]["groupTime"],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          ItemChat(
                            isSender: chatData[index]["penerima"] ==
                                    controller.emailPenerima
                                ? true
                                : false,
                            msg: "${chatData[index]["msg"]}",
                            time: timeString,
                          )
                        ],
                      );
                    }
                  }
                });
          }
          return Container();
        }),
  ));
}

class ItemChat extends StatelessWidget {
  const ItemChat(
      {Key? key, required this.isSender, required this.msg, required this.time})
      : super(key: key);

  final bool isSender;
  final String msg;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: isSender ? Colors.red[900] : Colors.red[700],
                borderRadius: isSender
                    ? BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15))
                    : BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
            padding: EdgeInsets.all(15),
            child: Text(
              "$msg",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(time)

          // DateFormat.jm().format(DateTime.parse(time))),
        ],
      ),
    );
  }
}

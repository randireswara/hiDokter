import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_news_controller.dart';

class DetailNewsView extends GetView<DetailNewsController> {
  DetailNewsView({Key? key}) : super(key: key);
  final date = DateFormat.yMMMd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final arguments = Get.arguments;
    String title = arguments["title"];
    String content = arguments["content"];
    String createdAt = arguments["createdAt"];
    String writer = arguments["writer"];
    String theme = arguments["theme"];
    String photoUrl = arguments["news"];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News Page',
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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 90,
                    height: 40,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 2, 78, 141),
                        borderRadius: BorderRadius.circular(10)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        theme,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Text(
                    createdAt,
                    style: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w700),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      writer,
                      style: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              CachedNetworkImage(
                imageUrl: photoUrl,
                imageBuilder: (context, imageProvider) => Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(photoUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black45, width: 1)),
                ),
                placeholder: (context, url) => Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/images/Loading_icon.gif"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black45, width: 1)),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  content,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

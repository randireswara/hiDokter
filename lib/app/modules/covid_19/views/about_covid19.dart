import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hi_dokter/app/modules/covid_19/controllers/covid_19_controller.dart';
import 'package:intl/intl.dart';

class AboutCovid19 extends StatelessWidget {
  AboutCovid19({Key? key}) : super(key: key);
  final date = DateFormat.yMMMd().format(DateTime.now());
  final controller = Get.put(Covid19Controller());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Covid 19',
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
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.aboutCovid(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var myData = snapshot.data!.data();
                  return Column(
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
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Covid 19",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Text(
                            date,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              myData!["title"],
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              myData["writer"],
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage("assets/images/tentang.png"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: Colors.black45, width: 1)),
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          myData["content"],
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}

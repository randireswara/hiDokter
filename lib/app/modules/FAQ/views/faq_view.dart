import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/faq_controller.dart';

class FaqView extends GetView<FaqController> {
  const FaqView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FAQ',
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.chatStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              var myData = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: myData.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            _showModal(context, myData[index]["pertanyaan"],
                                myData[index]["jawaban"]);
                          },
                          title: Text(myData[index]["pertanyaan"]),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey[300],
                        )
                      ],
                    );
                  },
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

void _showModal(context, String title, String subTitle) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          heightFactor: 0.8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  subTitle,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close Modal'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

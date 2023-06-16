import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_dokter/app/routes/app_pages.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../controllers/pilihan_dokter_controller.dart';

class PilihanDokterView extends GetView<PilihanDokterController> {
  const PilihanDokterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Choose Doctor',
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
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBar(
              controller: controller.searchController,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text(
                "Available",
                style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(child: UpcomingScheduleScreen())
            // ListView.builder()
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final controllerSearch = Get.put(PilihanDokterController());
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
              onChanged: (value) {
                controllerSearch.search(value);
              },
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

// ignore: must_be_immutable
class UpcomingScheduleScreen extends StatelessWidget {
  UpcomingScheduleScreen({super.key});

  String formattedTime = DateFormat('h:mm a').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PilihanDokterController());
    return Center(child: Obx(() {
      var search = controller.tempSearch.value;
      return Container(
        padding: EdgeInsets.all(controller.padding.value),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.streamDataDokter(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                var myData = snapshot.data!.docs;

                final filteredData = myData.where((doc) {
                  final name = doc['fullName'];
                  return name.toLowerCase().contains(search);
                }).toList();
                print(filteredData);
                if (filteredData.isEmpty) {
                  print("kosong");
                  return SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          Lottie.asset('assets/lottie/empty.json'),
                          const Text(
                            "Empty",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    String buka = filteredData[index]["bukaJanjiTemu"];
                    String tutup = filteredData[index]["tutupJanjiTemu"];
                    String waktu = "$buka - $tutup";
                    Map<String, dynamic> dataDoc = {
                      'fullName': filteredData[index]["fullName"],
                      'spesialis': filteredData[index]["spesialis"],
                      'jamBuka': waktu,
                      'hariBuka': filteredData[index]["dayOpen"],
                      'biografi': filteredData[index]["biografi"],
                      'email': filteredData[index]["email"],
                      'photoUrl': filteredData[index]["photoUrl"]
                    };

                    return Card(
                      elevation: 2.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: Container(
                          padding: const EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)),
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Image(
                                  image: NetworkImage(
                                      filteredData[index]["photoUrl"]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dataDoc["fullName"],
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    dataDoc["spesialis"],
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month,
                                        color: Colors.amber,
                                        size: 12,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        dataDoc["hariBuka"],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time_filled_rounded,
                                          color: Colors.amber, size: 12),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        waktu,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed(Routes.DETAIL_DOKTER,
                                            arguments: dataDoc);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10),
                                          backgroundColor: Colors.amber,
                                          side:
                                              BorderSide(color: Colors.amber)),
                                      child: const Text("Consultation"))
                                ],
                              )
                            ],
                          )),
                    );
                  },
                );
              }
              return Container();
            }),
      );
    }));
  }
}

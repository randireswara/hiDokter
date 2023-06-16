import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hi_dokter/app/modules/list_chat_for_pasien/views/chat_pasien_view.dart';
import 'package:hi_dokter/app/routes/app_pages.dart';

import '../controllers/pilih_konsultasi_controller.dart';

class PilihKonsultasiView extends GetView<PilihKonsultasiController> {
  const PilihKonsultasiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Choose Consultation',
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
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            InkWell(
              onTap: () => Get.to(() => const ChatPasienView()),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      border: Border.all(
                          color: Colors.grey[400]!,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[400]!,
                          spreadRadius: 4,
                          blurRadius: 9,
                          offset: Offset(0, 1),
                        ),
                      ]),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chat,
                        color: Colors.amber,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Chat With Doctor",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Spacer(),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => Get.toNamed(Routes.PILIHAN_DOKTER),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      border: Border.all(
                          color: Colors.grey[400]!,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[400]!,
                          spreadRadius: 4,
                          blurRadius: 9,
                          offset: Offset(0, 1),
                        ),
                      ]),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person_2,
                        color: Colors.amber,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Make A Appointment",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Spacer(),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

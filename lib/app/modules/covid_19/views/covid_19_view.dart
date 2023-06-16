import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hi_dokter/app/modules/covid_19/views/about_covid19.dart';
import 'package:hi_dokter/app/modules/covid_19/views/layanan_covid19.dart';
import 'package:hi_dokter/app/modules/covid_19/views/mencegah_covid19.dart';
import 'package:hi_dokter/app/modules/covid_19/views/mengobati_covid19.dart';

import '../controllers/covid_19_controller.dart';

class Covid19View extends GetView<Covid19Controller> {
  const Covid19View({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Covid 19',
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
        child: Column(
          children: [
            Container(
              width: Size,
              height: height * 0.4,
              decoration: BoxDecoration(color: Colors.amber),
              child: const Image(
                image: AssetImage("assets/images/halaman_covid_nobg.png"),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: Size,
              height: height * 0.5,
              color: Colors.white,
              padding: const EdgeInsets.all(15),
              child: Column(children: [
                Button(
                  Size: Size,
                  icon: Icons.question_mark_rounded,
                  label: "About Covid 19",
                  onTap: () {
                    Get.to(() => AboutCovid19());
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Button(
                  Size: Size,
                  icon: Icons.masks_outlined,
                  label: "Stop Covid 19",
                  onTap: () {
                    Get.to(() => StopCovid19());
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Button(
                  Size: Size,
                  icon: Icons.healing,
                  label: "Heal From Covid 19",
                  onTap: () {
                    Get.to(() => HealFromCovid19());
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Button(
                  Size: Size,
                  icon: Icons.coronavirus_rounded,
                  label: "I got covid 19",
                  onTap: () {
                    Get.to(() => CovidForm());
                  },
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button(
      {super.key,
      required this.Size,
      required this.icon,
      required this.label,
      required this.onTap});

  final double Size;
  final String label;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: Size,
        height: 60,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white70,
              border: Border.all(
                  color: Colors.grey[400]!, width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400]!,
                  spreadRadius: 4,
                  blurRadius: 9,
                  offset: const Offset(0, 1),
                ),
              ]),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.amber,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}

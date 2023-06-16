import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_dokter/app/modules/home/views/home_view.dart';

class SelamatDaftar extends StatelessWidget {
  const SelamatDaftar({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.2, horizontal: width * 0.2),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                    size: 150,
                  ),
                  Text(
                    "Congratulation Your Appointment has been successfully",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Get.to(() => const HomeView());
                      },
                      child: Text("Go To Home"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

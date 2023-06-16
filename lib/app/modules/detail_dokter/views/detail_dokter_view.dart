import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hi_dokter/app/data/model/appointment_model_model.dart';
import 'package:hi_dokter/app/modules/detail_dokter/views/constanta.dart';
import 'package:hi_dokter/app/routes/app_pages.dart';

import '../controllers/detail_dokter_controller.dart';

class DetailDokterView extends GetView<DetailDokterController> {
  const DetailDokterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final arguments = Get.arguments;
    // final model = AppointmentModel(
    //     dokterName: arguments!["fullName"],
    //     spesialis: arguments!["spesialis"],
    //     jamBuka: arguments!["jamBuka"],
    //     hariBuka: arguments!["hariBuka"],
    //     biografi: arguments!["biografi"]);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          '',
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
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(controller.appointmentModel.photoUrl!),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height * 0.7,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 25.0, left: 25, right: 25, bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.appointmentModel.dokterName!,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            controller.appointmentModel.spesialis!,
                            style: Theme.of(context).textTheme.displaySmall,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Colors.amber,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            controller.appointmentModel.jamBuka!,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(Icons.access_time_filled_rounded,
                              color: Colors.amber, size: 20),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            controller.appointmentModel.hariBuka!,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Biografi",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Text(
                        controller.appointmentModel.biografi!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(Routes.BOOK_APPOINTMENT);
                            },
                            child: Text("Book Appointment")),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hi_dokter/app/database/authentication/authentication_repository.dart';
import 'package:hi_dokter/app/modules/book_appointment/views/selamat_daftar.dart';
import 'package:hi_dokter/app/modules/detail_dokter/controllers/detail_dokter_controller.dart';
import 'package:hi_dokter/app/routes/app_pages.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../home/views/home_view.dart';
import '../controllers/book_appointment_controller.dart';

class BookAppointmentView extends GetView<BookAppointmentController> {
  const BookAppointmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataPasien = Get.put(AuthenticationRepository());
    final dataDokter = Get.put(DetailDokterController());
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Book Appointment',
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
        body: Obx(
          () => CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    _tableCalendar(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 25),
                      child: Center(
                        child: Text(
                          "Select Consultation Time",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              controller.isWeekend.value
                  ? SliverToBoxAdapter(
                      child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      alignment: Alignment.center,
                      child: Text(
                        "Weekend is not available, please select another date",
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                    ))
                  : SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            controller.updateIndexTime(
                                "${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}",
                                index);
                          },
                          child: Obx(() => Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: controller.currentIndex.value ==
                                                index
                                            ? Colors.white
                                            : Colors.black),
                                    borderRadius: BorderRadius.circular(15),
                                    color:
                                        controller.currentIndex.value == index
                                            ? Colors.amber
                                            : null),
                                alignment: Alignment.center,
                                child: Text(
                                  '${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          controller.currentIndex.value == index
                                              ? Colors.white
                                              : null),
                                ),
                              )),
                        );
                      }, childCount: 8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4, childAspectRatio: 2)),
              SliverToBoxAdapter(
                child: Obx(
                  () => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 25),
                        child: Center(
                          child: Text(
                            "Available Hour",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 25),
                        child: Center(
                          child: Text(
                            controller.hourAvailable.value.toString(),
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Obx(
                  () => SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 80),
                      child: ElevatedButton(
                        onPressed: controller.isWeekend.value
                            ? null
                            : () async {
                                String dateSelected = DateFormat.yMd()
                                    .format(controller.currentDay.value);
                                await controller
                                    .sendDataAppointment(
                                      dateSelected,
                                      controller.hourSelected.value,
                                      dataPasien.userModel.value.email!,
                                      dataDokter.appointmentModel.dokterName!,
                                      dataDokter.appointmentModel.emailDokter!,
                                      dataPasien.userModel.value.fullName!,
                                      dataDokter.appointmentModel.spesialis!,
                                    )
                                    .then((_) => Get.snackbar(
                                        "Success", "Success make Appointment"))
                                    .then((_) => Get.offAllNamed(Routes.HOME));
                                ;
                              },
                        child: const Text('Make Appointment'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _tableCalendar() {
    final controller = Get.put(BookAppointmentController());
    return Obx(() => TableCalendar(
          focusedDay: controller.focusDay.value,
          firstDay: DateTime.now(),
          lastDay: DateTime.now().add(const Duration(days: 7)),
          calendarFormat: controller.format1.value,
          currentDay: controller.currentDay.value,
          rowHeight: 48,
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
          ),
          availableCalendarFormats: const {CalendarFormat.month: 'Month'},
          onFormatChanged: (format) {
            controller.onFormatChange(format);
          },
          onDaySelected: (selectedDay, focusedDay) {
            controller.onDaySelected(selectedDay, focusedDay);
          },
        ));
  }
}

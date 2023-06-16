import 'package:get/get.dart';
import 'package:hi_dokter/app/data/model/appointment_model_model.dart';

class DetailDokterController extends GetxController {
  //TODO: Implement DetailDokterController

  late AppointmentModel appointmentModel = AppointmentModel();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    appointmentModel = AppointmentModel(
        dokterName: Get.arguments!["fullName"],
        spesialis: Get.arguments!["spesialis"],
        jamBuka: Get.arguments!["jamBuka"],
        hariBuka: Get.arguments!["hariBuka"],
        biografi: Get.arguments!["biografi"],
        emailDokter: Get.arguments!["email"],
        photoUrl: Get.arguments!["photoUrl"]);
  }
}

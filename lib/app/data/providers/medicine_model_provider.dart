import 'package:get/get.dart';

import '../model/medicine_model_model.dart';

class MedicineModelProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return MedicineModel.fromJson(map);
      if (map is List)
        return map.map((item) => MedicineModel.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<MedicineModel?> getMedicineModel(int id) async {
    final response = await get('medicinemodel/$id');
    return response.body;
  }

  Future<Response<MedicineModel>> postMedicineModel(
          MedicineModel medicinemodel) async =>
      await post('medicinemodel', medicinemodel);
  Future<Response> deleteMedicineModel(int id) async =>
      await delete('medicinemodel/$id');
}

class MedicineModel {
  String? drugName;
  String? longDay;
  String? howManyTime;
  String? hour;
  String? startDay;
  bool? isCompleted;

  MedicineModel(
      {this.drugName,
      this.longDay,
      this.howManyTime,
      this.hour,
      this.startDay,
      this.isCompleted});

  MedicineModel.fromJson(Map<String, dynamic> json) {
    drugName = json['drugName'];
    longDay = json['longDay'];
    howManyTime = json['howManyTime'];
    hour = json['hour'];
    startDay = json['startDay'];
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['drugName'] = drugName;
    data['longDay'] = longDay;
    data['howManyTime'] = howManyTime;
    data['hour'] = hour;
    data['startDay'] = startDay;
    data['isCompleted'] = isCompleted;
    return data;
  }
}

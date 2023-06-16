class AppointmentModel {
  String? dokterName;
  String? spesialis;
  String? jamBuka;
  String? hariBuka;
  String? biografi;
  String? emailDokter;
  String? photoUrl;

  AppointmentModel(
      {this.dokterName,
      this.spesialis,
      this.jamBuka,
      this.hariBuka,
      this.biografi,
      this.emailDokter,
      this.photoUrl});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    dokterName = json['dokterName'];
    spesialis = json['spesialis'];
    jamBuka = json['jamBuka'];
    hariBuka = json['hariBuka'];
    biografi = json['biografi'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['dokterName'] = dokterName;
    data['spesialis'] = spesialis;
    data['jamBuka'] = jamBuka;
    data['hariBuka'] = hariBuka;
    data['biografi'] = biografi;
    return data;
  }
}

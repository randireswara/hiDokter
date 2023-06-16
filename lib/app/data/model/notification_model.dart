class NotificationModel {
  String? createdAT;
  String? title;
  String? subtitle;

  NotificationModel({this.createdAT, this.title, this.subtitle});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    createdAT = json['createdAT'];
    title = json['title'];
    subtitle = json['subtitle'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['createdAT'] = createdAT;
    data['title'] = title;
    data['subtitle'] = subtitle;
    return data;
  }
}

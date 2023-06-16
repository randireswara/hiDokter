import 'dart:convert';

class UserModel {
  String? id;
  String? fullName;
  String? email;
  String? phoneNo;
  String? password;
  String? role;
  String? createdAt;
  String? division;
  String? companyName;
  String? photoUrl = "null";
  String? spesialis;
  String? biografi;

  UserModel(
      {this.id,
      this.fullName,
      this.email,
      this.phoneNo,
      this.password,
      this.role,
      this.createdAt,
      this.division,
      this.companyName,
      this.photoUrl,
      this.spesialis,
      this.biografi});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        fullName: json['fullName'],
        email: json['email'],
        phoneNo: json['phoneNo'],
        password: json['password'],
        role: json["role"],
        createdAt: json['createdAt'],
        division: json['division'],
        companyName: json['companyName'],
        photoUrl: json['photoUrl'],
        biografi: json['biografi'],
        spesialis: json['spesialis']);
  }

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'email': email,
        'phoneNo': phoneNo,
        'password': password,
        'role': role,
        'createdAt': createdAt,
        'division': division,
        'companyName': companyName,
        'photoUrl': photoUrl,
        'biografi': biografi,
        'spesialis': spesialis
      };
}

// To parse this JSON data, do
//
//     final updateProfileModel = updateProfileModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileModel updateProfileModelFromJson(String str) => UpdateProfileModel.fromJson(json.decode(str));

String updateProfileModelToJson(UpdateProfileModel data) => json.encode(data.toJson());

class UpdateProfileModel {
  bool? status;
  String? message;
  User? user;

  UpdateProfileModel({
    this.status,
    this.message,
    this.user,
  });

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) => UpdateProfileModel(
        status: json["status"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user?.toJson(),
      };
}

class User {
  String? id;
  int? uniqueId;
  String? name;
  String? image;
  String? email;
  String? mobile;
  String? gender;
  String? bio;
  DateTime? dob;
  String? analyticDate;
  bool? isBlock;
  String? fcmToken;
  bool? isDelete;
  bool? isUpdate;
  String? latitude;
  String? longitude;
  String? country;
  List<dynamic>? subPatient;
  List<dynamic>? doctors;
  String? password;
  int? loginType;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? age;

  User({
    this.id,
    this.uniqueId,
    this.name,
    this.image,
    this.email,
    this.mobile,
    this.gender,
    this.bio,
    this.dob,
    this.analyticDate,
    this.isBlock,
    this.fcmToken,
    this.isDelete,
    this.isUpdate,
    this.latitude,
    this.longitude,
    this.country,
    this.subPatient,
    this.doctors,
    this.password,
    this.loginType,
    this.createdAt,
    this.updatedAt,
    this.age,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        uniqueId: json["uniqueId"],
        name: json["name"],
        image: json["image"],
        email: json["email"],
        mobile: json["mobile"],
        gender: json["gender"],
        bio: json["bio"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        analyticDate: json["analyticDate"],
        isBlock: json["isBlock"],
        fcmToken: json["fcmToken"],
        isDelete: json["isDelete"],
        isUpdate: json["isUpdate"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        country: json["country"],
        subPatient: json["subPatient"] == null ? [] : List<dynamic>.from(json["subPatient"]!.map((x) => x)),
        doctors: json["doctors"] == null ? [] : List<dynamic>.from(json["doctors"]!.map((x) => x)),
        password: json["password"],
        loginType: json["loginType"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uniqueId": uniqueId,
        "name": name,
        "image": image,
        "email": email,
        "mobile": mobile,
        "gender": gender,
        "bio": bio,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "analyticDate": analyticDate,
        "isBlock": isBlock,
        "fcmToken": fcmToken,
        "isDelete": isDelete,
        "isUpdate": isUpdate,
        "latitude": latitude,
        "longitude": longitude,
        "country": country,
        "subPatient": subPatient == null ? [] : List<dynamic>.from(subPatient!.map((x) => x)),
        "doctors": doctors == null ? [] : List<dynamic>.from(doctors!.map((x) => x)),
        "password": password,
        "loginType": loginType,
        "createdAt": createdAt?.toString(),
        "updatedAt": updatedAt?.toString(),
        "age": age,
      };
}

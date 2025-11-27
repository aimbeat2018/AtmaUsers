// To parse this JSON data, do
//
//     final registrationModel = registrationModelFromJson(jsonString);

import 'dart:convert';

RegistrationModel registrationModelFromJson(String str) => RegistrationModel.fromJson(json.decode(str));

String registrationModelToJson(RegistrationModel data) => json.encode(data.toJson());

class RegistrationModel {
  bool? status;
  String? message;
  User? user;
  bool? signup;

  RegistrationModel({
    this.status,
    this.message,
    this.user,
    this.signup,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
        status: json["status"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        signup: json["signup"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user?.toJson(),
        "signup": signup,
      };
}

class User {
  String? id;
  // int? uniqueId;
  String? uniqueId;
  String? name;
  String? image;
  String? email;
  String? mobile;
  String? gender;
  String? bio;
  String? dob;
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
        dob: json["dob"],
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
        "dob": dob,
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
      };
}

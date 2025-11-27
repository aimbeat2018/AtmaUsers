import 'dart:convert';

GetUserProfileModel getUserProfileModelFromJson(String str) =>
    GetUserProfileModel.fromJson(json.decode(str));

String getUserProfileModelToJson(GetUserProfileModel data) =>
    json.encode(data.toJson());

class GetUserProfileModel {
  bool? status;
  int? membership;
  String? message;
  User? user;

  GetUserProfileModel({
    this.status,
    this.message,
    this.membership,
    this.user,
  });

  factory GetUserProfileModel.fromJson(Map<String, dynamic> json) =>
      GetUserProfileModel(
        status: json["status"],
        message: json["message"],
        membership: json["membership"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "membership": membership,
        "user": user?.toJson(),
      };
}

class User {
  String? id;
  String? uniqueId;
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
  List<String>? doctors;
  String? password;
  int? loginType;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? age;
  List<String>? subPatient;

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
    this.doctors,
    this.password,
    this.loginType,
    this.createdAt,
    this.updatedAt,
    this.age,
    this.subPatient,
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
        doctors: json["doctors"] == null
            ? []
            : List<String>.from(json["doctors"]!.map((x) => x)),
        password: json["password"],
        loginType: json["loginType"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        age: json["age"],
        subPatient: json["subPatient"] == null
            ? []
            : List<String>.from(json["subPatient"]!.map((x) => x)),
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
        "doctors":
            doctors == null ? [] : List<dynamic>.from(doctors!.map((x) => x)),
        "password": password,
        "loginType": loginType,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "age": age,
        "subPatient": subPatient == null
            ? []
            : List<dynamic>.from(subPatient!.map((x) => x)),
      };
}

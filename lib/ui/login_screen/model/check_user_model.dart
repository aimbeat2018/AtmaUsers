import 'dart:convert';

CheckUserModel checkUserModelFromJson(String str) => CheckUserModel.fromJson(json.decode(str));

String checkUserModelToJson(CheckUserModel data) => json.encode(data.toJson());

class CheckUserModel {
  bool? status;
  String? message;
  User? user;
  bool? isLogin;

  CheckUserModel({
    this.status,
    this.message,
    this.user,
    this.isLogin,
  });

  factory CheckUserModel.fromJson(Map<String, dynamic> json) => CheckUserModel(
        status: json["status"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        isLogin: json["isLogin"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user?.toJson(),
        "isLogin": isLogin,
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
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        analyticDate: json["analyticDate"],
        isBlock: json["isBlock"],
        fcmToken: json["fcmToken"],
        isDelete: json["isDelete"],
        isUpdate: json["isUpdate"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        country: json["country"],
        subPatient: json["subPatient"] == null
            ? []
            : json["subPatient"] is List
                ? List<dynamic>.from(json["subPatient"].map((x) => x))
                : [json["subPatient"]],
        doctors: json["doctors"] == null
            ? []
            : json["doctors"] is List
                ? List<dynamic>.from(json["doctors"].map((x) => x))
                : [json["doctors"]],
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
        "dob": dob?.toIso8601String(),
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
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

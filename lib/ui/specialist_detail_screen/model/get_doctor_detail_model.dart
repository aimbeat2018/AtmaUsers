// To parse this JSON data, do
//
//     final getDoctorDetailModel = getDoctorDetailModelFromJson(jsonString);

import 'dart:convert';

GetDoctorDetailModel getDoctorDetailModelFromJson(String str) => GetDoctorDetailModel.fromJson(json.decode(str));

String getDoctorDetailModelToJson(GetDoctorDetailModel data) => json.encode(data.toJson());

class GetDoctorDetailModel {
  bool? status;
  String? message;
  Data? data;
  num? patients;
  bool? isSaved;

  GetDoctorDetailModel({
    this.status,
    this.message,
    this.data,
    this.patients,
    this.isSaved,
  });

  factory GetDoctorDetailModel.fromJson(Map<String, dynamic> json) => GetDoctorDetailModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        patients: json["patients"],
        isSaved: json["isSaved"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "patients": patients,
        "isSaved": isSaved,
      };
}

class Data {
  BankDetails? bankDetails;
  List<String>? expertise;
  String? id;
  num? uniqueId;
  String? name;
  String? image;
  String? email;
  String? password;
  num? age;
  String? mobile;
  String? gender;
  DateTime? dob;
  bool? isBlock;
  String? fcmToken;
  bool? isDelete;
  num? bookingCount;
  num? wallet;
  List<Service>? service;
  String? designation;
  List<String>? degree;
  List<String>? language;
  num? experience;
  num? charge;
  num? type;
  String? latitude;
  String? longitude;
  String? country;
  String? clinicName;
  String? address;
  List<String>? awards;
  String? yourSelf;
  String? education;
  List<String>? experienceDetails;
  num? reviewCount;
  num? rating;
  List<Schedule>? schedule;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? commission;
  num? totalWallet;
  num? currentBookingCount;
  num? paymentType;
  String? upiId;
  bool? isAttend;
  bool? showDialog;
  num? timeSlot;

  Data({
    this.bankDetails,
    this.expertise,
    this.id,
    this.uniqueId,
    this.name,
    this.image,
    this.email,
    this.password,
    this.age,
    this.mobile,
    this.gender,
    this.dob,
    this.isBlock,
    this.fcmToken,
    this.isDelete,
    this.bookingCount,
    this.wallet,
    this.service,
    this.designation,
    this.degree,
    this.language,
    this.experience,
    this.charge,
    this.type,
    this.latitude,
    this.longitude,
    this.country,
    this.clinicName,
    this.address,
    this.awards,
    this.yourSelf,
    this.education,
    this.experienceDetails,
    this.reviewCount,
    this.rating,
    this.schedule,
    this.createdAt,
    this.updatedAt,
    this.commission,
    this.totalWallet,
    this.currentBookingCount,
    this.paymentType,
    this.upiId,
    this.isAttend,
    this.showDialog,
    this.timeSlot,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bankDetails: json["bankDetails"] == null ? null : BankDetails.fromJson(json["bankDetails"]),
        expertise: json["expertise"] == null ? [] : List<String>.from(json["expertise"]!.map((x) => x)),
        id: json["_id"],
        uniqueId: json["uniqueId"],
        name: json["name"],
        image: json["image"],
        email: json["email"],
        password: json["password"],
        age: json["age"],
        mobile: json["mobile"],
        gender: json["gender"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        isBlock: json["isBlock"],
        fcmToken: json["fcmToken"],
        isDelete: json["isDelete"],
        bookingCount: json["bookingCount"],
        wallet: json["wallet"]?.toDouble(),
        service: json["service"] == null ? [] : List<Service>.from(json["service"]!.map((x) => Service.fromJson(x))),
        designation: json["designation"],
        degree: json["degree"] == null ? [] : List<String>.from(json["degree"]!.map((x) => x)),
        language: json["language"] == null ? [] : List<String>.from(json["language"]!.map((x) => x)),
        experience: json["experience"],
        charge: json["charge"],
        type: json["type"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        country: json["country"],
        clinicName: json["clinicName"],
        address: json["address"],
        awards: json["awards"] == null ? [] : List<String>.from(json["awards"]!.map((x) => x)),
        yourSelf: json["yourSelf"],
        education: json["education"],
        experienceDetails: json["experienceDetails"] == null ? [] : List<String>.from(json["experienceDetails"]!.map((x) => x)),
        reviewCount: json["reviewCount"],
        rating: json["rating"],
        schedule: json["schedule"] == null ? [] : List<Schedule>.from(json["schedule"]!.map((x) => Schedule.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        commission: json["commission"],
        totalWallet: json["totalWallet"]?.toDouble(),
        currentBookingCount: json["currentBookingCount"],
        paymentType: json["paymentType"],
        upiId: json["upiId"],
        isAttend: json["isAttend"],
        showDialog: json["showDialog"],
        timeSlot: json["timeSlot"],
      );

  Map<String, dynamic> toJson() => {
        "bankDetails": bankDetails?.toJson(),
        "expertise": expertise == null ? [] : List<String>.from(expertise!.map((x) => x)),
        "_id": id,
        "uniqueId": uniqueId,
        "name": name,
        "image": image,
        "email": email,
        "password": password,
        "age": age,
        "mobile": mobile,
        "gender": gender,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "isBlock": isBlock,
        "fcmToken": fcmToken,
        "isDelete": isDelete,
        "bookingCount": bookingCount,
        "wallet": wallet,
        "service": service == null ? [] : List<dynamic>.from(service!.map((x) => x.toJson())),
        "designation": designation,
        "degree": degree == null ? [] : List<dynamic>.from(degree!.map((x) => x)),
        "language": language == null ? [] : List<dynamic>.from(language!.map((x) => x)),
        "experience": experience,
        "charge": charge,
        "type": type,
        "latitude": latitude,
        "longitude": longitude,
        "country": country,
        "clinicName": clinicName,
        "address": address,
        "awards": awards == null ? [] : List<dynamic>.from(awards!.map((x) => x)),
        "yourSelf": yourSelf,
        "education": education,
        "experienceDetails": experienceDetails == null ? [] : List<dynamic>.from(experienceDetails!.map((x) => x)),
        "reviewCount": reviewCount,
        "rating": rating,
        "schedule": schedule == null ? [] : List<dynamic>.from(schedule!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "commission": commission,
        "totalWallet": totalWallet,
        "currentBookingCount": currentBookingCount,
        "paymentType": paymentType,
        "upiId": upiId,
        "isAttend": isAttend,
        "showDialog": showDialog,
        "timeSlot": timeSlot,
      };
}

class BankDetails {
  String? bankName;
  String? accountNumber;
  String? ifscCode;
  String? branchName;

  BankDetails({
    this.bankName,
    this.accountNumber,
    this.ifscCode,
    this.branchName,
  });

  factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
        bankName: json["bankName"],
        accountNumber: json["accountNumber"],
        ifscCode: json["IFSCCode"],
        branchName: json["branchName"],
      );

  Map<String, dynamic> toJson() => {
        "bankName": bankName,
        "accountNumber": accountNumber,
        "IFSCCode": ifscCode,
        "branchName": branchName,
      };
}

class Schedule {
  num? timeSlot;
  String? day;
  String? startTime;
  String? endTime;
  String? breakStartTime;
  String? breakEndTime;
  num? time;
  String? id;

  Schedule({
    this.timeSlot,
    this.day,
    this.startTime,
    this.endTime,
    this.breakStartTime,
    this.breakEndTime,
    this.time,
    this.id,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        timeSlot: json["timeSlot"],
        day: json["day"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        breakStartTime: json["breakStartTime"],
        breakEndTime: json["breakEndTime"],
        time: json["time"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "timeSlot": timeSlot,
        "day": day,
        "startTime": startTime,
        "endTime": endTime,
        "breakStartTime": breakStartTime,
        "breakEndTime": breakEndTime,
        "time": time,
        "_id": id,
      };
}

class Service {
  String? id;
  bool? status;
  bool? isDelete;
  String? name;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  Service({
    this.id,
    this.status,
    this.isDelete,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["_id"],
        status: json["status"],
        isDelete: json["isDelete"],
        name: json["name"],
        image: json["image"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "isDelete": isDelete,
        "name": name,
        "image": image,
        "createdAt": createdAt?.toString(),
        "updatedAt": updatedAt?.toString(),
      };
}

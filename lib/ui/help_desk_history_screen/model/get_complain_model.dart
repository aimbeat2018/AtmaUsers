// To parse this JSON data, do
//
//     final getComplainModel = getComplainModelFromJson(jsonString);

import 'dart:convert';

GetComplainModel getComplainModelFromJson(String str) => GetComplainModel.fromJson(json.decode(str));

String getComplainModelToJson(GetComplainModel data) => json.encode(data.toJson());

class GetComplainModel {
  bool? status;
  String? message;
  int? total;
  List<Datum>? data;

  GetComplainModel({
    this.status,
    this.message,
    this.total,
    this.data,
  });

  factory GetComplainModel.fromJson(Map<String, dynamic> json) => GetComplainModel(
        status: json["status"],
        message: json["message"],
        total: json["total"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "total": total,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? id;
  int? appointmentId;
  String? details;
  String? image;
  int? type;
  bool? isComplain;
  Appointment? appointment;
  String? user;
  int? person;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.appointmentId,
    this.details,
    this.image,
    this.type,
    this.isComplain,
    this.appointment,
    this.user,
    this.person,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        appointmentId: json["appointmentId"],
        details: json["details"],
        image: json["image"],
        type: json["type"],
        isComplain: json["isComplain"],
        appointment: json["appointment"] == null ? null : Appointment.fromJson(json["appointment"]),
        user: json["user"],
        person: json["person"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "appointmentId": appointmentId,
        "details": details,
        "image": image,
        "type": type,
        "isComplain": isComplain,
        "appointment": appointment?.toJson(),
        "user": user,
        "person": person,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Appointment {
  String? id;
  String? appointmentId;

  Appointment({
    this.id,
    this.appointmentId,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json["_id"],
        appointmentId: json["appointmentId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "appointmentId": appointmentId,
      };
}

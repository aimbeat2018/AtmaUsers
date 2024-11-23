// To parse this JSON data, do
//
//     final raiseComplainModel = raiseComplainModelFromJson(jsonString);

import 'dart:convert';

RaiseComplainModel raiseComplainModelFromJson(String str) => RaiseComplainModel.fromJson(json.decode(str));

String raiseComplainModelToJson(RaiseComplainModel data) => json.encode(data.toJson());

class RaiseComplainModel {
  bool? status;
  String? message;
  Complain? complain;

  RaiseComplainModel({
    this.status,
    this.message,
    this.complain,
  });

  factory RaiseComplainModel.fromJson(Map<String, dynamic> json) => RaiseComplainModel(
        status: json["status"],
        message: json["message"],
        complain: json["complain"] == null ? null : Complain.fromJson(json["complain"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "complain": complain?.toJson(),
      };
}

class Complain {
  int? appointmentId;
  String? details;
  String? image;
  int? type;
  bool? isComplain;
  String? id;
  String? appointment;
  String? user;
  int? person;
  DateTime? createdAt;
  DateTime? updatedAt;

  Complain({
    this.appointmentId,
    this.details,
    this.image,
    this.type,
    this.isComplain,
    this.id,
    this.appointment,
    this.user,
    this.person,
    this.createdAt,
    this.updatedAt,
  });

  factory Complain.fromJson(Map<String, dynamic> json) => Complain(
        appointmentId: json["appointmentId"],
        details: json["details"],
        image: json["image"],
        type: json["type"],
        isComplain: json["isComplain"],
        id: json["_id"],
        appointment: json["appointment"],
        user: json["user"],
        person: json["person"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "appointmentId": appointmentId,
        "details": details,
        "image": image,
        "type": type,
        "isComplain": isComplain,
        "_id": id,
        "appointment": appointment,
        "user": user,
        "person": person,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

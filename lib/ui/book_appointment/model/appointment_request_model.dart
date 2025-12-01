// To parse this JSON data, do
//
//     final appointmentRequestModel = appointmentRequestModelFromJson(jsonString);

import 'dart:convert';

AppointmentRequestModel appointmentRequestModelFromJson(String str) => AppointmentRequestModel.fromJson(json.decode(str));

String appointmentRequestModelToJson(AppointmentRequestModel data) => json.encode(data.toJson());

class AppointmentRequestModel {
  bool? status;
  String? message;
  List<Datum>? data;

  AppointmentRequestModel({
    this.status,
    this.message,
    this.data,
  });

  factory AppointmentRequestModel.fromJson(Map<String, dynamic> json) => AppointmentRequestModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? note;
  String? appointmentDate;
  String? status;
  Kiosk? kiosk;

  Datum({
    this.id,
    this.note,
    this.appointmentDate,
    this.status,
    this.kiosk,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    note: json["note"],
    appointmentDate: json["appointment_date"],
    status: json["status"],
    kiosk: json["kiosk"] == null ? null : Kiosk.fromJson(json["kiosk"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "note": note,
    "appointment_date": appointmentDate,
    "status": status,
    "kiosk": kiosk?.toJson(),
  };
}

class Kiosk {
  String? hospitalName;
  String? flatNo;
  String? laneRoad;
  String? nearBy;
  int? pincode;

  Kiosk({
    this.hospitalName,
    this.flatNo,
    this.laneRoad,
    this.nearBy,
    this.pincode,
  });

  factory Kiosk.fromJson(Map<String, dynamic> json) => Kiosk(
    hospitalName: json["hospital_name"],
    flatNo: json["flat_no"],
    laneRoad: json["lane_road"],
    nearBy: json["near_by"],
    pincode: json["pincode"],
  );

  Map<String, dynamic> toJson() => {
    "hospital_name": hospitalName,
    "flat_no": flatNo,
    "lane_road": laneRoad,
    "near_by": nearBy,
    "pincode": pincode,
  };
}

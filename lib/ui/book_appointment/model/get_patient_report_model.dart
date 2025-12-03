// To parse this JSON data, do
//
//     final getPatientReportModel = getPatientReportModelFromJson(jsonString);

import 'dart:convert';

GetPatientReportModel getPatientReportModelFromJson(String str) => GetPatientReportModel.fromJson(json.decode(str));

String getPatientReportModelToJson(GetPatientReportModel data) => json.encode(data.toJson());

class GetPatientReportModel {
  bool? status;
  String? message;
  List<Datum>? data;

  GetPatientReportModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetPatientReportModel.fromJson(Map<String, dynamic> json) => GetPatientReportModel(
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
  String? patientId;
  String? file;
  String? description;
  bool? isDelete;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.patientId,
    this.file,
    this.description,
    this.isDelete,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    patientId: json["patient_id"],
    file: json["file"],
    description: json["description"],
    isDelete: json["is_delete"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "patient_id": patientId,
    "file": file,
    "description": description,
    "is_delete": isDelete,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

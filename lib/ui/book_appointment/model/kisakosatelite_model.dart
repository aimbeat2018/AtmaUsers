// To parse this JSON data, do
//
//     final kisakoSateliteListResponse = kisakoSateliteListResponseFromJson(jsonString);

import 'dart:convert';

KisakoSateliteListResponse kisakoSateliteListResponseFromJson(String str) => KisakoSateliteListResponse.fromJson(json.decode(str));

String kisakoSateliteListResponseToJson(KisakoSateliteListResponse data) => json.encode(data.toJson());

class KisakoSateliteListResponse {
  bool? status;
  String? message;
  List<Datum>? data;

  KisakoSateliteListResponse({
    this.status,
    this.message,
    this.data,
  });

  factory KisakoSateliteListResponse.fromJson(Map<String, dynamic> json) => KisakoSateliteListResponse(
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
  String? type;
  String? hospitalName;
  String? flatNo;
  String? building;
  String? laneRoad;
  String? nearBy;
  String? area;
  String? country;
  String? state;
  String? district;
  String? taluka;
  int? pincode;
  bool? status;
  bool? isDelete;
  int? tagLimit;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.type,
    this.hospitalName,
    this.flatNo,
    this.building,
    this.laneRoad,
    this.nearBy,
    this.area,
    this.country,
    this.state,
    this.district,
    this.taluka,
    this.pincode,
    this.status,
    this.isDelete,
    this.tagLimit,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    type: json["type"],
    hospitalName: json["hospital_name"],
    flatNo: json["flat_no"],
    building: json["building"],
    laneRoad: json["lane_road"],
    nearBy: json["near_by"],
    area: json["area"],
    country: json["country"],
    state: json["state"],
    district: json["district"],
    taluka: json["taluka"],
    pincode: json["pincode"],
    status: json["status"],
    isDelete: json["isDelete"],
    tagLimit: json["tag_limit"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "type": type,
    "hospital_name": hospitalName,
    "flat_no": flatNo,
    "building": building,
    "lane_road": laneRoad,
    "near_by": nearBy,
    "area": area,
    "country": country,
    "state": state,
    "district": district,
    "taluka": taluka,
    "pincode": pincode,
    "status": status,
    "isDelete": isDelete,
    "tag_limit": tagLimit,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

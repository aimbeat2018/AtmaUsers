import 'dart:convert';

GetAllBannerModel getAllBannerModelFromJson(String str) => GetAllBannerModel.fromJson(json.decode(str));

String getAllBannerModelToJson(GetAllBannerModel data) => json.encode(data.toJson());

class GetAllBannerModel {
  bool? status;
  String? message;
  List<Datum>? data;

  GetAllBannerModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetAllBannerModel.fromJson(Map<String, dynamic> json) => GetAllBannerModel(
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
  bool? isActive;
  String? image;
  int? type;
  Service? service;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? url;

  Datum({
    this.id,
    this.isActive,
    this.image,
    this.type,
    this.service,
    this.createdAt,
    this.updatedAt,
    this.url,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        isActive: json["isActive"],
        image: json["image"],
        type: json["type"],
        service: json["service"] == null ? null : Service.fromJson(json["service"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "isActive": isActive,
        "image": image,
        "type": type,
        "service": service?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "url": url,
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
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

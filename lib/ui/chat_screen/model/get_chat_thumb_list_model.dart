// To parse this JSON data, do
//
//     final getChatThumbListModel = getChatThumbListModelFromJson(jsonString);

import 'dart:convert';

GetChatThumbListModel getChatThumbListModelFromJson(String str) => GetChatThumbListModel.fromJson(json.decode(str));

String getChatThumbListModelToJson(GetChatThumbListModel data) => json.encode(data.toJson());

class GetChatThumbListModel {
  bool? status;
  String? message;
  List<Datum>? data;

  GetChatThumbListModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetChatThumbListModel.fromJson(Map<String, dynamic> json) => GetChatThumbListModel(
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
  String? chatTopic;
  String? sender;
  String? senderName;
  String? senderImage;
  List<String>? services;
  String? message;
  String? role;
  String? name;
  String? image;
  String? user;
  String? time;

  Datum({
    this.id,
    this.chatTopic,
    this.sender,
    this.senderName,
    this.senderImage,
    this.services,
    this.message,
    this.role,
    this.name,
    this.image,
    this.user,
    this.time,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        chatTopic: json["chatTopic"],
        sender: json["sender"],
        senderName: json["senderName"],
        senderImage: json["senderImage"],
        services: json["services"] == null ? [] : List<String>.from(json["services"]!.map((x) => x)),
        message: json["message"],
        role: json["role"],
        name: json["name"],
        image: json["image"],
        user: json["user"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "chatTopic": chatTopic,
        "sender": sender,
        "senderName": senderName,
        "senderImage": senderImage,
        "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
        "message": message,
        "role": role,
        "name": name,
        "image": image,
        "user": user,
        "time": time,
      };
}

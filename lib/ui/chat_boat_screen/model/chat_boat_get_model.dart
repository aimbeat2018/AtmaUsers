import 'dart:convert';

ChatBoatGetModel chatBoatGetModelFromJson(String str) => ChatBoatGetModel.fromJson(json.decode(str));
String chatBoatGetModelToJson(ChatBoatGetModel data) => json.encode(data.toJson());

class ChatBoatGetModel {
  ChatBoatGetModel({
    bool? status,
    String? message,
    ChatBoatGet? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  ChatBoatGetModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? ChatBoatGet.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  ChatBoatGet? _data;
  ChatBoatGetModel copyWith({
    bool? status,
    String? message,
    ChatBoatGet? data,
  }) =>
      ChatBoatGetModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  ChatBoatGet? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

ChatBoatGet dataFromJson(String str) => ChatBoatGet.fromJson(json.decode(str));
String dataToJson(ChatBoatGet data) => json.encode(data.toJson());

class ChatBoatGet {
  ChatBoatGet({
    String? id,
    String? user,
    List<GetMessage>? message,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _user = user;
    _message = message;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  ChatBoatGet.fromJson(dynamic json) {
    _id = json['_id'];
    _user = json['user'];
    if (json['message'] != null) {
      _message = [];
      json['message'].forEach((v) {
        _message?.add(GetMessage.fromJson(v));
      });
    }
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _user;
  List<GetMessage>? _message;
  String? _createdAt;
  String? _updatedAt;
  ChatBoatGet copyWith({
    String? id,
    String? user,
    List<GetMessage>? message,
    String? createdAt,
    String? updatedAt,
  }) =>
      ChatBoatGet(
        id: id ?? _id,
        user: user ?? _user,
        message: message ?? _message,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get user => _user;
  List<GetMessage>? get message => _message;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['user'] = _user;
    if (_message != null) {
      map['message'] = _message?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

GetMessage messageFromJson(String str) => GetMessage.fromJson(json.decode(str));
String messageToJson(GetMessage data) => json.encode(data.toJson());

class GetMessage {
  GetMessage({
    String? text,
    String? time,
    bool? isSendByUser,
    String? id,
  }) {
    _text = text;
    _time = time;
    _isSendByUser = isSendByUser;
    _id = id;
  }

  GetMessage.fromJson(dynamic json) {
    _text = json['text'];
    _time = json['time'];
    _isSendByUser = json['isSendByUser'];
    _id = json['_id'];
  }
  String? _text;
  String? _time;
  bool? _isSendByUser;
  String? _id;
  GetMessage copyWith({
    String? text,
    String? time,
    bool? isSendByUser,
    String? id,
  }) =>
      GetMessage(
        text: text ?? _text,
        time: time ?? _time,
        isSendByUser: isSendByUser ?? _isSendByUser,
        id: id ?? _id,
      );
  String? get text => _text;
  String? get time => _time;
  bool? get isSendByUser => _isSendByUser;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    map['time'] = _time;
    map['isSendByUser'] = _isSendByUser;
    map['_id'] = _id;
    return map;
  }
}

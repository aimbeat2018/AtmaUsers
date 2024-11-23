import 'dart:convert';

ChatBoatCreateModel chatBoatCreateModelFromJson(String str) => ChatBoatCreateModel.fromJson(json.decode(str));
String chatBoatCreateModelToJson(ChatBoatCreateModel data) => json.encode(data.toJson());

class ChatBoatCreateModel {
  ChatBoatCreateModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  ChatBoatCreateModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
  ChatBoatCreateModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      ChatBoatCreateModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

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

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? id,
    String? user,
    List<CreateMessage>? message,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _user = user;
    _message = message;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _user = json['user'];
    if (json['message'] != null) {
      _message = [];
      json['message'].forEach((v) {
        _message?.add(CreateMessage.fromJson(v));
      });
    }
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _user;
  List<CreateMessage>? _message;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    String? id,
    String? user,
    List<CreateMessage>? message,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? _id,
        user: user ?? _user,
        message: message ?? _message,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get user => _user;
  List<CreateMessage>? get message => _message;
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

CreateMessage messageFromJson(String str) => CreateMessage.fromJson(json.decode(str));
String messageToJson(CreateMessage data) => json.encode(data.toJson());

class CreateMessage {
  CreateMessage({
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

  CreateMessage.fromJson(dynamic json) {
    _text = json['text'];
    _time = json['time'];
    _isSendByUser = json['isSendByUser'];
    _id = json['_id'];
  }
  String? _text;
  String? _time;
  bool? _isSendByUser;
  String? _id;
  CreateMessage copyWith({
    String? text,
    String? time,
    bool? isSendByUser,
    String? id,
  }) =>
      CreateMessage(
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

import 'dart:convert';

GetOldChatModel getOldChatModelFromJson(String str) => GetOldChatModel.fromJson(json.decode(str));
String getOldChatModelToJson(GetOldChatModel data) => json.encode(data.toJson());

class GetOldChatModel {
  GetOldChatModel({
    bool? status,
    String? message,
    String? chatTopic,
    List<GetOldChat>? chat,
  }) {
    _status = status;
    _message = message;
    _chatTopic = chatTopic;
    _chat = chat;
  }

  GetOldChatModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _chatTopic = json['chatTopic'];
    if (json['chat'] != null) {
      _chat = [];
      json['chat'].forEach((v) {
        _chat?.add(GetOldChat.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  String? _chatTopic;
  List<GetOldChat>? _chat;
  GetOldChatModel copyWith({
    bool? status,
    String? message,
    String? chatTopic,
    List<GetOldChat>? chat,
  }) =>
      GetOldChatModel(
        status: status ?? _status,
        message: message ?? _message,
        chatTopic: chatTopic ?? _chatTopic,
        chat: chat ?? _chat,
      );
  bool? get status => _status;
  String? get message => _message;
  String? get chatTopic => _chatTopic;
  List<GetOldChat>? get chat => _chat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['chatTopic'] = _chatTopic;
    if (_chat != null) {
      map['chat'] = _chat?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

GetOldChat chatFromJson(String str) => GetOldChat.fromJson(json.decode(str));
String chatToJson(GetOldChat data) => json.encode(data.toJson());

class GetOldChat {
  GetOldChat({
    String? id,
    String? chatTopic,
    String? doctor,
    String? user,
    String? message,
    String? image,
    String? video,
    String? thumbnail,
    bool? isRead,
    String? date,
    String? messageType,
    num? callType,
    String? callId,
    String? role,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _chatTopic = chatTopic;
    _doctor = doctor;
    _user = user;
    _message = message;
    _image = image;
    _video = video;
    _thumbnail = thumbnail;
    _isRead = isRead;
    _date = date;
    _messageType = messageType;
    _callType = callType;
    _callId = callId;
    _role = role;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  GetOldChat.fromJson(dynamic json) {
    _id = json['_id'];
    _chatTopic = json['chatTopic'];
    _doctor = json['doctor'];
    _user = json['user'];
    _message = json['message'];
    _image = json['image'];
    _video = json['video'];
    _thumbnail = json['thumbnail'];
    _isRead = json['isRead'];
    _date = json['date'];
    _messageType = json['messageType'];
    _callType = json['callType'];
    _callId = json['callId'];
    _role = json['role'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _chatTopic;
  String? _doctor;
  String? _user;
  String? _message;
  String? _image;
  String? _video;
  String? _thumbnail;
  bool? _isRead;
  String? _date;
  String? _messageType;
  num? _callType;
  String? _callId;
  String? _role;
  String? _createdAt;
  String? _updatedAt;
  GetOldChat copyWith({
    String? id,
    String? chatTopic,
    String? doctor,
    String? user,
    String? message,
    String? image,
    String? video,
    String? thumbnail,
    bool? isRead,
    String? date,
    String? messageType,
    num? callType,
    String? callId,
    String? role,
    String? createdAt,
    String? updatedAt,
  }) =>
      GetOldChat(
        id: id ?? _id,
        chatTopic: chatTopic ?? _chatTopic,
        doctor: doctor ?? _doctor,
        user: user ?? _user,
        message: message ?? _message,
        image: image ?? _image,
        video: video ?? _video,
        thumbnail: thumbnail ?? _thumbnail,
        isRead: isRead ?? _isRead,
        date: date ?? _date,
        messageType: messageType ?? _messageType,
        callType: callType ?? _callType,
        callId: callId ?? _callId,
        role: role ?? _role,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get chatTopic => _chatTopic;
  String? get doctor => _doctor;
  String? get user => _user;
  String? get message => _message;
  String? get image => _image;
  String? get video => _video;
  String? get thumbnail => _thumbnail;
  bool? get isRead => _isRead;
  String? get date => _date;
  String? get messageType => _messageType;
  num? get callType => _callType;
  String? get callId => _callId;
  String? get role => _role;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['chatTopic'] = _chatTopic;
    map['doctor'] = _doctor;
    map['user'] = _user;
    map['message'] = _message;
    map['image'] = _image;
    map['video'] = _video;
    map['thumbnail'] = _thumbnail;
    map['isRead'] = _isRead;
    map['date'] = _date;
    map['messageType'] = _messageType;
    map['callType'] = _callType;
    map['callId'] = _callId;
    map['role'] = _role;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

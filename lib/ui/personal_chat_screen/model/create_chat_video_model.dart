import 'dart:convert';

CreateChatVideoModel createChatVideoModelFromJson(String str) => CreateChatVideoModel.fromJson(json.decode(str));
String createChatVideoModelToJson(CreateChatVideoModel data) => json.encode(data.toJson());

class CreateChatVideoModel {
  CreateChatVideoModel({
    bool? status,
    String? message,
    Chat? chat,
  }) {
    _status = status;
    _message = message;
    _chat = chat;
  }

  CreateChatVideoModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _chat = json['chat'] != null ? Chat.fromJson(json['chat']) : null;
  }
  bool? _status;
  String? _message;
  Chat? _chat;
  CreateChatVideoModel copyWith({
    bool? status,
    String? message,
    Chat? chat,
  }) =>
      CreateChatVideoModel(
        status: status ?? _status,
        message: message ?? _message,
        chat: chat ?? _chat,
      );
  bool? get status => _status;
  String? get message => _message;
  Chat? get chat => _chat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_chat != null) {
      map['chat'] = _chat?.toJson();
    }
    return map;
  }
}

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));
String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
  Chat({
    String? chatTopic,
    String? doctor,
    String? user,
    String? message,
    String? image,
    String? video,
    String? thumbnail,
    bool? isRead,
    String? date,
    String? id,
    String? role,
    String? messageType,
    String? createdAt,
    String? updatedAt,
  }) {
    _chatTopic = chatTopic;
    _doctor = doctor;
    _user = user;
    _message = message;
    _image = image;
    _video = video;
    _thumbnail = thumbnail;
    _isRead = isRead;
    _date = date;
    _id = id;
    _role = role;
    _messageType = messageType;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Chat.fromJson(dynamic json) {
    _chatTopic = json['chatTopic'];
    _doctor = json['doctor'];
    _user = json['user'];
    _message = json['message'];
    _image = json['image'];
    _video = json['video'];
    _thumbnail = json['thumbnail'];
    _isRead = json['isRead'];
    _date = json['date'];
    _id = json['_id'];
    _role = json['role'];
    _messageType = json['messageType'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _chatTopic;
  String? _doctor;
  String? _user;
  String? _message;
  String? _image;
  String? _video;
  String? _thumbnail;
  bool? _isRead;
  String? _date;
  String? _id;
  String? _role;
  String? _messageType;
  String? _createdAt;
  String? _updatedAt;
  Chat copyWith({
    String? chatTopic,
    String? doctor,
    String? user,
    String? message,
    String? image,
    String? video,
    String? thumbnail,
    bool? isRead,
    String? date,
    String? id,
    String? role,
    String? messageType,
    String? createdAt,
    String? updatedAt,
  }) =>
      Chat(
        chatTopic: chatTopic ?? _chatTopic,
        doctor: doctor ?? _doctor,
        user: user ?? _user,
        message: message ?? _message,
        image: image ?? _image,
        video: video ?? _video,
        thumbnail: thumbnail ?? _thumbnail,
        isRead: isRead ?? _isRead,
        date: date ?? _date,
        id: id ?? _id,
        role: role ?? _role,
        messageType: messageType ?? _messageType,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get chatTopic => _chatTopic;
  String? get doctor => _doctor;
  String? get user => _user;
  String? get message => _message;
  String? get image => _image;
  String? get video => _video;
  String? get thumbnail => _thumbnail;
  bool? get isRead => _isRead;
  String? get date => _date;
  String? get id => _id;
  String? get role => _role;
  String? get messageType => _messageType;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chatTopic'] = _chatTopic;
    map['doctor'] = _doctor;
    map['user'] = _user;
    map['message'] = _message;
    map['image'] = _image;
    map['video'] = _video;
    map['thumbnail'] = _thumbnail;
    map['isRead'] = _isRead;
    map['date'] = _date;
    map['_id'] = _id;
    map['role'] = _role;
    map['messageType'] = _messageType;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

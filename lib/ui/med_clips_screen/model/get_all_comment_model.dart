import 'dart:convert';

GetAllCommentModel getAllCommentModelFromJson(String str) => GetAllCommentModel.fromJson(json.decode(str));
String getAllCommentModelToJson(GetAllCommentModel data) => json.encode(data.toJson());

class GetAllCommentModel {
  GetAllCommentModel({
    bool? status,
    String? message,
    List<GetAllComment>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetAllCommentModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetAllComment.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<GetAllComment>? _data;
  GetAllCommentModel copyWith({
    bool? status,
    String? message,
    List<GetAllComment>? data,
  }) =>
      GetAllCommentModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<GetAllComment>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

GetAllComment dataFromJson(String str) => GetAllComment.fromJson(json.decode(str));
String dataToJson(GetAllComment data) => json.encode(data.toJson());

class GetAllComment {
  GetAllComment({
    String? id,
    String? commentText,
    String? createdAt,
    String? userId,
    String? name,
    String? userImage,
    String? time,
  }) {
    _id = id;
    _commentText = commentText;
    _createdAt = createdAt;
    _userId = userId;
    _name = name;
    _userImage = userImage;
    _time = time;
  }

  GetAllComment.fromJson(dynamic json) {
    _id = json['_id'];
    _commentText = json['commentText'];
    _createdAt = json['createdAt'];
    _userId = json['userId'];
    _name = json['name'];
    _userImage = json['userImage'];
    _time = json['time'];
  }
  String? _id;
  String? _commentText;
  String? _createdAt;
  String? _userId;
  String? _name;
  String? _userImage;
  String? _time;
  GetAllComment copyWith({
    String? id,
    String? commentText,
    String? createdAt,
    String? userId,
    String? name,
    String? userImage,
    String? time,
  }) =>
      GetAllComment(
        id: id ?? _id,
        commentText: commentText ?? _commentText,
        createdAt: createdAt ?? _createdAt,
        userId: userId ?? _userId,
        name: name ?? _name,
        userImage: userImage ?? _userImage,
        time: time ?? _time,
      );
  String? get id => _id;
  String? get commentText => _commentText;
  String? get createdAt => _createdAt;
  String? get userId => _userId;
  String? get name => _name;
  String? get userImage => _userImage;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['commentText'] = _commentText;
    map['createdAt'] = _createdAt;
    map['userId'] = _userId;
    map['name'] = _name;
    map['userImage'] = _userImage;
    map['time'] = _time;
    return map;
  }
}

import 'dart:convert';

CreateCommentModel createCommentModelFromJson(String str) => CreateCommentModel.fromJson(json.decode(str));
String createCommentModelToJson(CreateCommentModel data) => json.encode(data.toJson());

class CreateCommentModel {
  CreateCommentModel({
    bool? status,
    String? message,
    CreateComment? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  CreateCommentModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? CreateComment.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  CreateComment? _data;
  CreateCommentModel copyWith({
    bool? status,
    String? message,
    CreateComment? data,
  }) =>
      CreateCommentModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  CreateComment? get data => _data;

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

CreateComment dataFromJson(String str) => CreateComment.fromJson(json.decode(str));
String dataToJson(CreateComment data) => json.encode(data.toJson());

class CreateComment {
  CreateComment({
    String? user,
    String? video,
    String? commentText,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) {
    _user = user;
    _video = video;
    _commentText = commentText;
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  CreateComment.fromJson(dynamic json) {
    _user = json['user'];
    _video = json['video'];
    _commentText = json['commentText'];
    _id = json['_id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _user;
  String? _video;
  String? _commentText;
  String? _id;
  String? _createdAt;
  String? _updatedAt;
  CreateComment copyWith({
    String? user,
    String? video,
    String? commentText,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) =>
      CreateComment(
        user: user ?? _user,
        video: video ?? _video,
        commentText: commentText ?? _commentText,
        id: id ?? _id,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get user => _user;
  String? get video => _video;
  String? get commentText => _commentText;
  String? get id => _id;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = _user;
    map['video'] = _video;
    map['commentText'] = _commentText;
    map['_id'] = _id;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

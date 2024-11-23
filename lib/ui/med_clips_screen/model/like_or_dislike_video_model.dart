import 'dart:convert';

LikeOrDislikeVideoModel likeOrDislikeVideoModelFromJson(String str) => LikeOrDislikeVideoModel.fromJson(json.decode(str));
String likeOrDislikeVideoModelToJson(LikeOrDislikeVideoModel data) => json.encode(data.toJson());

class LikeOrDislikeVideoModel {
  LikeOrDislikeVideoModel({
    bool? status,
    String? message,
    bool? isLike,
  }) {
    _status = status;
    _message = message;
    _isLike = isLike;
  }

  LikeOrDislikeVideoModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _isLike = json['isLike'];
  }
  bool? _status;
  String? _message;
  bool? _isLike;
  LikeOrDislikeVideoModel copyWith({
    bool? status,
    String? message,
    bool? isLike,
  }) =>
      LikeOrDislikeVideoModel(
        status: status ?? _status,
        message: message ?? _message,
        isLike: isLike ?? _isLike,
      );
  bool? get status => _status;
  String? get message => _message;
  bool? get isLike => _isLike;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['isLike'] = _isLike;
    return map;
  }
}

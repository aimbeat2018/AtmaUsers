import 'dart:convert';

PostReviewModel postReviewModelFromJson(String str) => PostReviewModel.fromJson(json.decode(str));
String postReviewModelToJson(PostReviewModel data) => json.encode(data.toJson());

class PostReviewModel {
  PostReviewModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  PostReviewModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
  PostReviewModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      PostReviewModel(
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
    String? review,
    num? rating,
    String? callId,
    String? id,
    String? user,
    String? doctor,
    String? createdAt,
    String? updatedAt,
  }) {
    _review = review;
    _rating = rating;
    _callId = callId;
    _id = id;
    _user = user;
    _doctor = doctor;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _review = json['review'];
    _rating = json['rating'];
    _callId = json['callId'];
    _id = json['_id'];
    _user = json['user'];
    _doctor = json['doctor'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _review;
  num? _rating;
  String? _callId;
  String? _id;
  String? _user;
  String? _doctor;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    String? review,
    num? rating,
    String? callId,
    String? id,
    String? user,
    String? doctor,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        review: review ?? _review,
        rating: rating ?? _rating,
        callId: callId ?? _callId,
        id: id ?? _id,
        user: user ?? _user,
        doctor: doctor ?? _doctor,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get review => _review;
  num? get rating => _rating;
  String? get callId => _callId;
  String? get id => _id;
  String? get user => _user;
  String? get doctor => _doctor;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['review'] = _review;
    map['rating'] = _rating;
    map['callId'] = _callId;
    map['_id'] = _id;
    map['user'] = _user;
    map['doctor'] = _doctor;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

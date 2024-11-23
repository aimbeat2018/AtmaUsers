import 'dart:convert';

GetDoctorRatingModel getDoctorRatingModelFromJson(String str) => GetDoctorRatingModel.fromJson(json.decode(str));
String getDoctorRatingModelToJson(GetDoctorRatingModel data) => json.encode(data.toJson());

class GetDoctorRatingModel {
  GetDoctorRatingModel({
    bool? status,
    String? message,
    num? total,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _total = total;
    _data = data;
  }

  GetDoctorRatingModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _total = json['total'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  num? _total;
  List<Data>? _data;
  GetDoctorRatingModel copyWith({
    bool? status,
    String? message,
    num? total,
    List<Data>? data,
  }) =>
      GetDoctorRatingModel(
        status: status ?? _status,
        message: message ?? _message,
        total: total ?? _total,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  num? get total => _total;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['total'] = _total;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? id,
    num? rating,
    String? appointment,
    User? user,
    Doctor? doctor,
    String? review,
    String? createdAt,
    String? updatedAt,
    String? relativeTime,
  }) {
    _id = id;
    _rating = rating;
    _appointment = appointment;
    _user = user;
    _doctor = doctor;
    _review = review;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _relativeTime = relativeTime;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _rating = json['rating'];
    _appointment = json['appointment'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    _review = json['review'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _relativeTime = json['relativeTime'];
  }
  String? _id;
  num? _rating;
  String? _appointment;
  User? _user;
  Doctor? _doctor;
  String? _review;
  String? _createdAt;
  String? _updatedAt;
  String? _relativeTime;
  Data copyWith({
    String? id,
    num? rating,
    String? appointment,
    User? user,
    Doctor? doctor,
    String? review,
    String? createdAt,
    String? updatedAt,
    String? relativeTime,
  }) =>
      Data(
        id: id ?? _id,
        rating: rating ?? _rating,
        appointment: appointment ?? _appointment,
        user: user ?? _user,
        doctor: doctor ?? _doctor,
        review: review ?? _review,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        relativeTime: relativeTime ?? _relativeTime,
      );
  String? get id => _id;
  num? get rating => _rating;
  String? get appointment => _appointment;
  User? get user => _user;
  Doctor? get doctor => _doctor;
  String? get review => _review;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get relativeTime => _relativeTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['rating'] = _rating;
    map['appointment'] = _appointment;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_doctor != null) {
      map['doctor'] = _doctor?.toJson();
    }
    map['review'] = _review;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['relativeTime'] = _relativeTime;
    return map;
  }
}

Doctor doctorFromJson(String str) => Doctor.fromJson(json.decode(str));
String doctorToJson(Doctor data) => json.encode(data.toJson());

class Doctor {
  Doctor({
    String? id,
    String? name,
    String? image,
  }) {
    _id = id;
    _name = name;
    _image = image;
  }

  Doctor.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _image = json['image'];
  }
  String? _id;
  String? _name;
  String? _image;
  Doctor copyWith({
    String? id,
    String? name,
    String? image,
  }) =>
      Doctor(
        id: id ?? _id,
        name: name ?? _name,
        image: image ?? _image,
      );
  String? get id => _id;
  String? get name => _name;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    return map;
  }
}

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    String? id,
    String? name,
    String? image,
  }) {
    _id = id;
    _name = name;
    _image = image;
  }

  User.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _image = json['image'];
  }
  String? _id;
  String? _name;
  String? _image;
  User copyWith({
    String? id,
    String? name,
    String? image,
  }) =>
      User(
        id: id ?? _id,
        name: name ?? _name,
        image: image ?? _image,
      );
  String? get id => _id;
  String? get name => _name;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    return map;
  }
}

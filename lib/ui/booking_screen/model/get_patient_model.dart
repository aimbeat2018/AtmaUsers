import 'dart:convert';

GetPatientModel getPatientModelFromJson(String str) => GetPatientModel.fromJson(json.decode(str));
String getPatientModelToJson(GetPatientModel data) => json.encode(data.toJson());

class GetPatientModel {
  GetPatientModel({
    bool? status,
    String? message,
    List<PatientData>? getPatientData,
  }) {
    _status = status;
    _message = message;
    _data = getPatientData;
  }

  GetPatientModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(PatientData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<PatientData>? _data;
  GetPatientModel copyWith({
    bool? status,
    String? message,
    List<PatientData>? data,
  }) =>
      GetPatientModel(
        status: status ?? _status,
        message: message ?? _message,
        getPatientData: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<PatientData>? get data => _data;

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

PatientData dataFromJson(String str) => PatientData.fromJson(json.decode(str));
String dataToJson(PatientData data) => json.encode(data.toJson());

class PatientData {
  PatientData({
    String? id,
    String? user,
    String? name,
    String? gender,
    String? relation,
    num? age,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _user = user;
    _name = name;
    _gender = gender;
    _relation = relation;
    _age = age;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  PatientData.fromJson(dynamic json) {
    _id = json['_id'];
    _user = json['user'];
    _name = json['name'];
    _gender = json['gender'];
    _relation = json['relation'];
    _age = json['age'];
    _image = json['image'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _user;
  String? _name;
  String? _gender;
  String? _relation;
  num? _age;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
  PatientData copyWith({
    String? id,
    String? user,
    String? name,
    String? gender,
    String? relation,
    num? age,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) =>
      PatientData(
        id: id ?? _id,
        user: user ?? _user,
        name: name ?? _name,
        gender: gender ?? _gender,
        relation: relation ?? _relation,
        age: age ?? _age,
        image: image ?? _image,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get user => _user;
  String? get name => _name;
  String? get gender => _gender;
  String? get relation => _relation;
  num? get age => _age;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['user'] = _user;
    map['name'] = _name;
    map['gender'] = _gender;
    map['relation'] = _relation;
    map['age'] = _age;
    map['image'] = _image;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

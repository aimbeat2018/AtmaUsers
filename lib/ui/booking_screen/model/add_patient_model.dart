import 'dart:convert';

AddPatientModel addPatientModelFromJson(String str) => AddPatientModel.fromJson(json.decode(str));
String addPatientModelToJson(AddPatientModel data) => json.encode(data.toJson());

class AddPatientModel {
  AddPatientModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  AddPatientModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
  AddPatientModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      AddPatientModel(
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
    String? user,
    String? name,
    String? gender,
    String? relation,
    num? age,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) {
    _user = user;
    _name = name;
    _gender = gender;
    _relation = relation;
    _age = age;
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _user = json['user'];
    _name = json['name'];
    _gender = json['gender'];
    _relation = json['relation'];
    _age = json['age'];
    _id = json['_id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _user;
  String? _name;
  String? _gender;
  String? _relation;
  num? _age;
  String? _id;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    String? user,
    String? name,
    String? gender,
    String? relation,
    num? age,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        user: user ?? _user,
        name: name ?? _name,
        gender: gender ?? _gender,
        relation: relation ?? _relation,
        age: age ?? _age,
        id: id ?? _id,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get user => _user;
  String? get name => _name;
  String? get gender => _gender;
  String? get relation => _relation;
  num? get age => _age;
  String? get id => _id;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = _user;
    map['name'] = _name;
    map['gender'] = _gender;
    map['relation'] = _relation;
    map['age'] = _age;
    map['_id'] = _id;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

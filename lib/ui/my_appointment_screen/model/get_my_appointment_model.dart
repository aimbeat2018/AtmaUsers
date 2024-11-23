import 'dart:convert';

GetMyAppointmentModel getMyAppointmentModelFromJson(String str) => GetMyAppointmentModel.fromJson(json.decode(str));
String getMyAppointmentModelToJson(GetMyAppointmentModel data) => json.encode(data.toJson());

class GetMyAppointmentModel {
  GetMyAppointmentModel({
    bool? status,
    String? message,
    num? total,
    List<GetMyAppointmentData>? data,
  }) {
    _status = status;
    _message = message;
    _total = total;
    _data = data;
  }

  GetMyAppointmentModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _total = json['total'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetMyAppointmentData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  num? _total;
  List<GetMyAppointmentData>? _data;
  GetMyAppointmentModel copyWith({
    bool? status,
    String? message,
    num? total,
    List<GetMyAppointmentData>? data,
  }) =>
      GetMyAppointmentModel(
        status: status ?? _status,
        message: message ?? _message,
        total: total ?? _total,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  num? get total => _total;
  List<GetMyAppointmentData>? get data => _data;

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

GetMyAppointmentData dataFromJson(String str) => GetMyAppointmentData.fromJson(json.decode(str));
String dataToJson(GetMyAppointmentData data) => json.encode(data.toJson());

class GetMyAppointmentData {
  GetMyAppointmentData({
    String? id,
    User? user,
    Doctor? doctor,
    String? service,
    String? time,
    num? status,
    String? appointmentId,
    String? date,
    num? type,
    num? amount,
    num? withoutTax,
    num? adminEarning,
    num? doctorEarning,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _user = user;
    _doctor = doctor;
    _service = service;
    _time = time;
    _status = status;
    _appointmentId = appointmentId;
    _date = date;
    _type = type;
    _amount = amount;
    _withoutTax = withoutTax;
    _adminEarning = adminEarning;
    _doctorEarning = doctorEarning;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  GetMyAppointmentData.fromJson(dynamic json) {
    _id = json['_id'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    _service = json['service'];
    _time = json['time'];
    _status = json['status'];
    _appointmentId = json['appointmentId'];
    _date = json['date'];
    _type = json['type'];
    _amount = json['amount'];
    _withoutTax = json['withoutTax'];
    _adminEarning = json['adminEarning'];
    _doctorEarning = json['doctorEarning'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  User? _user;
  Doctor? _doctor;
  String? _service;
  String? _time;
  num? _status;
  String? _appointmentId;
  String? _date;
  num? _type;
  num? _amount;
  num? _withoutTax;
  num? _adminEarning;
  num? _doctorEarning;
  String? _createdAt;
  String? _updatedAt;
  GetMyAppointmentData copyWith({
    String? id,
    User? user,
    Doctor? doctor,
    String? service,
    String? time,
    num? status,
    String? appointmentId,
    String? date,
    num? type,
    num? amount,
    num? withoutTax,
    num? adminEarning,
    num? doctorEarning,
    String? createdAt,
    String? updatedAt,
  }) =>
      GetMyAppointmentData(
        id: id ?? _id,
        user: user ?? _user,
        doctor: doctor ?? _doctor,
        service: service ?? _service,
        time: time ?? _time,
        status: status ?? _status,
        appointmentId: appointmentId ?? _appointmentId,
        date: date ?? _date,
        type: type ?? _type,
        amount: amount ?? _amount,
        withoutTax: withoutTax ?? _withoutTax,
        adminEarning: adminEarning ?? _adminEarning,
        doctorEarning: doctorEarning ?? _doctorEarning,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  User? get user => _user;
  Doctor? get doctor => _doctor;
  String? get service => _service;
  String? get time => _time;
  num? get status => _status;
  String? get appointmentId => _appointmentId;
  String? get date => _date;
  num? get type => _type;
  num? get amount => _amount;
  num? get withoutTax => _withoutTax;
  num? get adminEarning => _adminEarning;
  num? get doctorEarning => _doctorEarning;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_doctor != null) {
      map['doctor'] = _doctor?.toJson();
    }
    map['service'] = _service;
    map['time'] = _time;
    map['status'] = _status;
    map['appointmentId'] = _appointmentId;
    map['date'] = _date;
    map['type'] = _type;
    map['amount'] = _amount;
    map['withoutTax'] = _withoutTax;
    map['adminEarning'] = _adminEarning;
    map['doctorEarning'] = _doctorEarning;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
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
    String? designation,
    List<String>? degree,
  }) {
    _id = id;
    _name = name;
    _image = image;
    _designation = designation;
    _degree = degree;
  }

  Doctor.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _image = json['image'];
    _designation = json['designation'];
    _degree = json['degree'] != null ? json['degree'].cast<String>() : [];
  }
  String? _id;
  String? _name;
  String? _image;
  String? _designation;
  List<String>? _degree;
  Doctor copyWith({
    String? id,
    String? name,
    String? image,
    String? designation,
    List<String>? degree,
  }) =>
      Doctor(
        id: id ?? _id,
        name: name ?? _name,
        image: image ?? _image,
        designation: designation ?? _designation,
        degree: degree ?? _degree,
      );
  String? get id => _id;
  String? get name => _name;
  String? get image => _image;
  String? get designation => _designation;
  List<String>? get degree => _degree;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['designation'] = _designation;
    map['degree'] = _degree;
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

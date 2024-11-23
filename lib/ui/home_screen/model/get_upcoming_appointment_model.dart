import 'dart:convert';

GetUpcomingAppointmentModel getUpcomingAppointmentModelFromJson(String str) =>
    GetUpcomingAppointmentModel.fromJson(json.decode(str));
String getUpcomingAppointmentModelToJson(GetUpcomingAppointmentModel data) => json.encode(data.toJson());

class GetUpcomingAppointmentModel {
  GetUpcomingAppointmentModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetUpcomingAppointmentModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
  GetUpcomingAppointmentModel copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      GetUpcomingAppointmentModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

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

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? id,
    User? user,
    Doctor? doctor,
    Service? service,
    String? time,
    num? status,
    String? appointmentId,
    String? date,
    bool? isReviewed,
    num? type,
    num? duration,
    num? amount,
    num? tax,
    num? withoutTax,
    num? discount,
    num? adminEarning,
    num? adminCommissionPercent,
    num? doctorEarning,
    bool? isSettle,
    String? details,
    String? image,
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
    _isReviewed = isReviewed;
    _type = type;
    _duration = duration;
    _amount = amount;
    _tax = tax;
    _withoutTax = withoutTax;
    _discount = discount;
    _adminEarning = adminEarning;
    _adminCommissionPercent = adminCommissionPercent;
    _doctorEarning = doctorEarning;
    _isSettle = isSettle;
    _details = details;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    _service = json['service'] != null ? Service.fromJson(json['service']) : null;
    _time = json['time'];
    _status = json['status'];
    _appointmentId = json['appointmentId'];
    _date = json['date'];
    _isReviewed = json['isReviewed'];
    _type = json['type'];
    _duration = json['duration'];
    _amount = json['amount'];
    _tax = json['tax'];
    _withoutTax = json['withoutTax'];
    _discount = json['discount'];
    _adminEarning = json['adminEarning'];
    _adminCommissionPercent = json['adminCommissionPercent'];
    _doctorEarning = json['doctorEarning'];
    _isSettle = json['isSettle'];
    _details = json['details'];
    _image = json['image'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  User? _user;
  Doctor? _doctor;
  Service? _service;
  String? _time;
  num? _status;
  String? _appointmentId;
  String? _date;
  bool? _isReviewed;
  num? _type;
  num? _duration;
  num? _amount;
  num? _tax;
  num? _withoutTax;
  num? _discount;
  num? _adminEarning;
  num? _adminCommissionPercent;
  num? _doctorEarning;
  bool? _isSettle;
  String? _details;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    String? id,
    User? user,
    Doctor? doctor,
    Service? service,
    String? time,
    num? status,
    String? appointmentId,
    String? date,
    bool? isReviewed,
    num? type,
    num? duration,
    num? amount,
    num? tax,
    num? withoutTax,
    num? discount,
    num? adminEarning,
    num? adminCommissionPercent,
    num? doctorEarning,
    bool? isSettle,
    String? details,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? _id,
        user: user ?? _user,
        doctor: doctor ?? _doctor,
        service: service ?? _service,
        time: time ?? _time,
        status: status ?? _status,
        appointmentId: appointmentId ?? _appointmentId,
        date: date ?? _date,
        isReviewed: isReviewed ?? _isReviewed,
        type: type ?? _type,
        duration: duration ?? _duration,
        amount: amount ?? _amount,
        tax: tax ?? _tax,
        withoutTax: withoutTax ?? _withoutTax,
        discount: discount ?? _discount,
        adminEarning: adminEarning ?? _adminEarning,
        adminCommissionPercent: adminCommissionPercent ?? _adminCommissionPercent,
        doctorEarning: doctorEarning ?? _doctorEarning,
        isSettle: isSettle ?? _isSettle,
        details: details ?? _details,
        image: image ?? _image,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  User? get user => _user;
  Doctor? get doctor => _doctor;
  Service? get service => _service;
  String? get time => _time;
  num? get status => _status;
  String? get appointmentId => _appointmentId;
  String? get date => _date;
  bool? get isReviewed => _isReviewed;
  num? get type => _type;
  num? get duration => _duration;
  num? get amount => _amount;
  num? get tax => _tax;
  num? get withoutTax => _withoutTax;
  num? get discount => _discount;
  num? get adminEarning => _adminEarning;
  num? get adminCommissionPercent => _adminCommissionPercent;
  num? get doctorEarning => _doctorEarning;
  bool? get isSettle => _isSettle;
  String? get details => _details;
  String? get image => _image;
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
    if (_service != null) {
      map['service'] = _service?.toJson();
    }
    map['time'] = _time;
    map['status'] = _status;
    map['appointmentId'] = _appointmentId;
    map['date'] = _date;
    map['isReviewed'] = _isReviewed;
    map['type'] = _type;
    map['duration'] = _duration;
    map['amount'] = _amount;
    map['tax'] = _tax;
    map['withoutTax'] = _withoutTax;
    map['discount'] = _discount;
    map['adminEarning'] = _adminEarning;
    map['adminCommissionPercent'] = _adminCommissionPercent;
    map['doctorEarning'] = _doctorEarning;
    map['isSettle'] = _isSettle;
    map['details'] = _details;
    map['image'] = _image;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

Service serviceFromJson(String str) => Service.fromJson(json.decode(str));
String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
  Service({
    String? id,
    String? name,
    String? image,
  }) {
    _id = id;
    _name = name;
    _image = image;
  }

  Service.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _image = json['image'];
  }
  String? _id;
  String? _name;
  String? _image;
  Service copyWith({
    String? id,
    String? name,
    String? image,
  }) =>
      Service(
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

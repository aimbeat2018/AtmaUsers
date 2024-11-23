import 'dart:convert';

GetAppointmentInformationModel getAppointmentInformationModelFromJson(String str) =>
    GetAppointmentInformationModel.fromJson(json.decode(str));
String getAppointmentInformationModelToJson(GetAppointmentInformationModel data) => json.encode(data.toJson());

class GetAppointmentInformationModel {
  GetAppointmentInformationModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetAppointmentInformationModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
  GetAppointmentInformationModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      GetAppointmentInformationModel(
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
    Cancel? cancel,
    String? id,
    String? user,
    Doctor? doctor,
    String? service,
    Patient? patient,
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
    _cancel = cancel;
    _id = id;
    _user = user;
    _doctor = doctor;
    _service = service;
    _patient = patient;
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
    _cancel = json['cancel'] != null ? Cancel.fromJson(json['cancel']) : null;
    _id = json['_id'];
    _user = json['user'];
    _doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    _service = json['service'];
    _patient = json['patient'] != null ? Patient.fromJson(json['patient']) : null;
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
  Cancel? _cancel;
  String? _id;
  String? _user;
  Doctor? _doctor;
  String? _service;
  Patient? _patient;
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
    Cancel? cancel,
    String? id,
    String? user,
    Doctor? doctor,
    String? service,
    Patient? patient,
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
        cancel: cancel ?? _cancel,
        id: id ?? _id,
        user: user ?? _user,
        doctor: doctor ?? _doctor,
        service: service ?? _service,
        patient: patient ?? _patient,
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
  Cancel? get cancel => _cancel;
  String? get id => _id;
  String? get user => _user;
  Doctor? get doctor => _doctor;
  String? get service => _service;
  Patient? get patient => _patient;
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
    if (_cancel != null) {
      map['cancel'] = _cancel?.toJson();
    }
    map['_id'] = _id;
    map['user'] = _user;
    if (_doctor != null) {
      map['doctor'] = _doctor?.toJson();
    }
    map['service'] = _service;
    if (_patient != null) {
      map['patient'] = _patient?.toJson();
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

Patient patientFromJson(String str) => Patient.fromJson(json.decode(str));
String patientToJson(Patient data) => json.encode(data.toJson());

class Patient {
  Patient({
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

  Patient.fromJson(dynamic json) {
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
  Patient copyWith({
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
      Patient(
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

Doctor doctorFromJson(String str) => Doctor.fromJson(json.decode(str));
String doctorToJson(Doctor data) => json.encode(data.toJson());

class Doctor {
  Doctor({
    String? id,
    String? name,
    String? image,
    String? designation,
    List<String>? degree,
    String? latitude,
    String? longitude,
    String? clinicName,
    String? address,
  }) {
    _id = id;
    _name = name;
    _image = image;
    _designation = designation;
    _degree = degree;
    _latitude = latitude;
    _longitude = longitude;
    _clinicName = clinicName;
    _address = address;
  }

  Doctor.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _image = json['image'];
    _designation = json['designation'];
    _degree = json['degree'] != null ? json['degree'].cast<String>() : [];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _clinicName = json['clinicName'];
    _address = json['address'];
  }
  String? _id;
  String? _name;
  String? _image;
  String? _designation;
  List<String>? _degree;
  String? _latitude;
  String? _longitude;
  String? _clinicName;
  String? _address;
  Doctor copyWith({
    String? id,
    String? name,
    String? image,
    String? designation,
    List<String>? degree,
    String? latitude,
    String? longitude,
    String? clinicName,
    String? address,
  }) =>
      Doctor(
        id: id ?? _id,
        name: name ?? _name,
        image: image ?? _image,
        designation: designation ?? _designation,
        degree: degree ?? _degree,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        clinicName: clinicName ?? _clinicName,
        address: address ?? _address,
      );
  String? get id => _id;
  String? get name => _name;
  String? get image => _image;
  String? get designation => _designation;
  List<String>? get degree => _degree;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get clinicName => _clinicName;
  String? get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['designation'] = _designation;
    map['degree'] = _degree;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['clinicName'] = _clinicName;
    map['address'] = _address;
    return map;
  }
}

Cancel cancelFromJson(String str) => Cancel.fromJson(json.decode(str));
String cancelToJson(Cancel data) => json.encode(data.toJson());

class Cancel {
  Cancel({
    String? date,
    String? person,
    String? reason,
    String? time,
  }) {
    _date = date;
    _person = person;
    _reason = reason;
    _time = time;
  }

  Cancel.fromJson(dynamic json) {
    _date = json['date'];
    _person = json['person'];
    _reason = json['reason'];
    _time = json['time'];
  }
  String? _date;
  String? _person;
  String? _reason;
  String? _time;
  Cancel copyWith({
    String? date,
    String? person,
    String? reason,
    String? time,
  }) =>
      Cancel(
        date: date ?? _date,
        person: person ?? _person,
        reason: reason ?? _reason,
        time: time ?? _time,
      );
  String? get date => _date;
  String? get person => _person;
  String? get reason => _reason;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['person'] = _person;
    map['reason'] = _reason;
    map['time'] = _time;
    return map;
  }
}

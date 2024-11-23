import 'dart:convert';

CancelAppointmentModel cancelAppointmentModelFromJson(String str) => CancelAppointmentModel.fromJson(json.decode(str));
String cancelAppointmentModelToJson(CancelAppointmentModel data) => json.encode(data.toJson());

class CancelAppointmentModel {
  CancelAppointmentModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  CancelAppointmentModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
  CancelAppointmentModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      CancelAppointmentModel(
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
    String? doctor,
    String? service,
    String? patient,
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
    _doctor = json['doctor'];
    _service = json['service'];
    _patient = json['patient'];
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
  String? _doctor;
  String? _service;
  String? _patient;
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
    String? doctor,
    String? service,
    String? patient,
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
  String? get doctor => _doctor;
  String? get service => _service;
  String? get patient => _patient;
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
    map['doctor'] = _doctor;
    map['service'] = _service;
    map['patient'] = _patient;
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

Cancel cancelFromJson(String str) => Cancel.fromJson(json.decode(str));
String cancelToJson(Cancel data) => json.encode(data.toJson());

class Cancel {
  Cancel({
    String? person,
    String? time,
    String? date,
    String? reason,
  }) {
    _person = person;
    _time = time;
    _date = date;
    _reason = reason;
  }

  Cancel.fromJson(dynamic json) {
    _person = json['person'];
    _time = json['time'];
    _date = json['date'];
    _reason = json['reason'];
  }
  String? _person;
  String? _time;
  String? _date;
  String? _reason;
  Cancel copyWith({
    String? person,
    String? time,
    String? date,
    String? reason,
  }) =>
      Cancel(
        person: person ?? _person,
        time: time ?? _time,
        date: date ?? _date,
        reason: reason ?? _reason,
      );
  String? get person => _person;
  String? get time => _time;
  String? get date => _date;
  String? get reason => _reason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['person'] = _person;
    map['time'] = _time;
    map['date'] = _date;
    map['reason'] = _reason;
    return map;
  }
}

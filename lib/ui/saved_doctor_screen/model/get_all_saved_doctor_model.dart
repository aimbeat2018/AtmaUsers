import 'dart:convert';

GetAllSavedDoctorModel getAllSavedDoctorModelFromJson(String str) => GetAllSavedDoctorModel.fromJson(json.decode(str));
String getAllSavedDoctorModelToJson(GetAllSavedDoctorModel data) => json.encode(data.toJson());

class GetAllSavedDoctorModel {
  GetAllSavedDoctorModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetAllSavedDoctorModel.fromJson(dynamic json) {
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
  GetAllSavedDoctorModel copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      GetAllSavedDoctorModel(
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
    String? name,
    String? image,
    bool? isBlock,
    bool? isDelete,
    List<String>? service,
    String? designation,
    List<String>? degree,
    String? clinicName,
    num? rating,
  }) {
    _id = id;
    _name = name;
    _image = image;
    _isBlock = isBlock;
    _isDelete = isDelete;
    _service = service;
    _designation = designation;
    _degree = degree;
    _clinicName = clinicName;
    _rating = rating;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _image = json['image'];
    _isBlock = json['isBlock'];
    _isDelete = json['isDelete'];
    _service = json['service'] != null ? json['service'].cast<String>() : [];
    _designation = json['designation'];
    _degree = json['degree'] != null ? json['degree'].cast<String>() : [];
    _clinicName = json['clinicName'];
    _rating = json['rating'];
  }
  String? _id;
  String? _name;
  String? _image;
  bool? _isBlock;
  bool? _isDelete;
  List<String>? _service;
  String? _designation;
  List<String>? _degree;
  String? _clinicName;
  num? _rating;
  Data copyWith({
    String? id,
    String? name,
    String? image,
    bool? isBlock,
    bool? isDelete,
    List<String>? service,
    String? designation,
    List<String>? degree,
    String? clinicName,
    num? rating,
  }) =>
      Data(
        id: id ?? _id,
        name: name ?? _name,
        image: image ?? _image,
        isBlock: isBlock ?? _isBlock,
        isDelete: isDelete ?? _isDelete,
        service: service ?? _service,
        designation: designation ?? _designation,
        degree: degree ?? _degree,
        clinicName: clinicName ?? _clinicName,
        rating: rating ?? _rating,
      );
  String? get id => _id;
  String? get name => _name;
  String? get image => _image;
  bool? get isBlock => _isBlock;
  bool? get isDelete => _isDelete;
  List<String>? get service => _service;
  String? get designation => _designation;
  List<String>? get degree => _degree;
  String? get clinicName => _clinicName;
  num? get rating => _rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['isBlock'] = _isBlock;
    map['isDelete'] = _isDelete;
    map['service'] = _service;
    map['designation'] = _designation;
    map['degree'] = _degree;
    map['clinicName'] = _clinicName;
    map['rating'] = _rating;
    return map;
  }
}

import 'dart:convert';

GetAllServiceModel getAllServiceModelFromJson(String str) => GetAllServiceModel.fromJson(json.decode(str));
String getAllServiceModelToJson(GetAllServiceModel data) => json.encode(data.toJson());

class GetAllServiceModel {
  GetAllServiceModel({
    bool? status,
    String? message,
    List<CategoryData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetAllServiceModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CategoryData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<CategoryData>? _data;
  GetAllServiceModel copyWith({
    bool? status,
    String? message,
    List<CategoryData>? data,
  }) =>
      GetAllServiceModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<CategoryData>? get data => _data ?? [];

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

CategoryData dataFromJson(String str) => CategoryData.fromJson(json.decode(str));
String dataToJson(CategoryData data) => json.encode(data.toJson());

class CategoryData {
  CategoryData({
    String? id,
    String? name,
    String? image,
    bool? status,
    String? createdAt,
  }) {
    _id = id;
    _name = name;
    _image = image;
    _status = status;
    _createdAt = createdAt;
  }

  CategoryData.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _image = json['image'];
    _status = json['status'];
    _createdAt = json['createdAt'];
  }
  String? _id;
  String? _name;
  String? _image;
  bool? _status;
  String? _createdAt;
  CategoryData copyWith({
    String? id,
    String? name,
    String? image,
    bool? status,
    String? createdAt,
  }) =>
      CategoryData(
        id: id ?? _id,
        name: name ?? _name,
        image: image ?? _image,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
      );
  String? get id => _id;
  String? get name => _name;
  String? get image => _image;
  bool? get status => _status;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['status'] = _status;
    map['createdAt'] = _createdAt;
    return map;
  }
}

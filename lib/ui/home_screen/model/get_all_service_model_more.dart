import 'dart:convert';

GetAllServiceModelMore getAllServiceModelFromJson(String str) => GetAllServiceModelMore.fromJson(json.decode(str));
String getAllServiceModelToJson(GetAllServiceModelMore data) => json.encode(data.toJson());

class GetAllServiceModelMore {
  GetAllServiceModelMore({
    bool? status,
    String? message,
    List<CategoryMoreData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetAllServiceModelMore.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CategoryMoreData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<CategoryMoreData>? _data;
  GetAllServiceModelMore copyWith({
    bool? status,
    String? message,
    List<CategoryMoreData>? data,
  }) =>
      GetAllServiceModelMore(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<CategoryMoreData>? get data => _data ?? [];

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

CategoryMoreData dataFromJson(String str) => CategoryMoreData.fromJson(json.decode(str));
String dataToJson(CategoryMoreData data) => json.encode(data.toJson());

class CategoryMoreData {
  CategoryMoreData({
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

  CategoryMoreData.fromJson(dynamic json) {
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
  CategoryMoreData copyWith({
    String? id,
    String? name,
    String? image,
    bool? status,
    String? createdAt,
  }) =>
      CategoryMoreData(
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

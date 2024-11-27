import 'dart:convert';

GetUserWalletModel getUserWalletModelFromJson(String str) => GetUserWalletModel.fromJson(json.decode(str));
String getUserWalletModelToJson(GetUserWalletModel data) => json.encode(data.toJson());

class GetUserWalletModel {
  GetUserWalletModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetUserWalletModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
  GetUserWalletModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      GetUserWalletModel(
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
    String? id,
    String? user,
    num? amount,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _user = user;
    _amount = amount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _user = json['user'];
    _amount = json['amount'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _user;
  num? _amount;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    String? id,
    String? user,
    num? amount,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? _id,
        user: user ?? _user,
        amount: amount ?? _amount,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get user => _user;
  num? get amount => _amount;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['user'] = _user;
    map['amount'] = _amount;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

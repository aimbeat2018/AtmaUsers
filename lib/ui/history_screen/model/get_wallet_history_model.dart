import 'dart:convert';

GetWalletHistoryModel getWalletHistoryModelFromJson(String str) => GetWalletHistoryModel.fromJson(json.decode(str));
String getWalletHistoryModelToJson(GetWalletHistoryModel data) => json.encode(data.toJson());

class GetWalletHistoryModel {
  GetWalletHistoryModel({
    bool? status,
    String? message,
    num? total,
    List<GetWalletHistory>? data,
  }) {
    _status = status;
    _message = message;
    _total = total;
    _data = data;
  }

  GetWalletHistoryModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _total = json['total'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetWalletHistory.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  num? _total;
  List<GetWalletHistory>? _data;
  GetWalletHistoryModel copyWith({
    bool? status,
    String? message,
    num? total,
    List<GetWalletHistory>? data,
  }) =>
      GetWalletHistoryModel(
        status: status ?? _status,
        message: message ?? _message,
        total: total ?? _total,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  num? get total => _total;
  List<GetWalletHistory>? get data => _data;

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

GetWalletHistory dataFromJson(String str) => GetWalletHistory.fromJson(json.decode(str));
String dataToJson(GetWalletHistory data) => json.encode(data.toJson());

class GetWalletHistory {
  GetWalletHistory({
    String? id,
    String? user,
    String? wallet,
    num? amount,
    String? date,
    num? paymentGateway,
    num? type,
    String? uniqueId,
    String? time,
    String? createdAt,
    String? updatedAt,
    String? month,
  }) {
    _id = id;
    _user = user;
    _wallet = wallet;
    _amount = amount;
    _date = date;
    _paymentGateway = paymentGateway;
    _type = type;
    _uniqueId = uniqueId;
    _time = time;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _month = month;
  }

  GetWalletHistory.fromJson(dynamic json) {
    _id = json['_id'];
    _user = json['user'];
    _wallet = json['wallet'];
    _amount = json['amount'];
    _date = json['date'];
    _paymentGateway = json['paymentGateway'];
    _type = json['type'];
    _uniqueId = json['uniqueId'];
    _time = json['time'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _month = json['month'];
  }
  String? _id;
  String? _user;
  String? _wallet;
  num? _amount;
  String? _date;
  num? _paymentGateway;
  num? _type;
  String? _uniqueId;
  String? _time;
  String? _createdAt;
  String? _updatedAt;
  String? _month;
  GetWalletHistory copyWith({
    String? id,
    String? user,
    String? wallet,
    num? amount,
    String? date,
    num? paymentGateway,
    num? type,
    String? uniqueId,
    String? time,
    String? createdAt,
    String? updatedAt,
    String? month,
  }) =>
      GetWalletHistory(
        id: id ?? _id,
        user: user ?? _user,
        wallet: wallet ?? _wallet,
        amount: amount ?? _amount,
        date: date ?? _date,
        paymentGateway: paymentGateway ?? _paymentGateway,
        type: type ?? _type,
        uniqueId: uniqueId ?? _uniqueId,
        time: time ?? _time,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        month: month ?? _month,
      );
  String? get id => _id;
  String? get user => _user;
  String? get wallet => _wallet;
  num? get amount => _amount;
  String? get date => _date;
  num? get paymentGateway => _paymentGateway;
  num? get type => _type;
  String? get uniqueId => _uniqueId;
  String? get time => _time;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get month => _month;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['user'] = _user;
    map['wallet'] = _wallet;
    map['amount'] = _amount;
    map['date'] = _date;
    map['paymentGateway'] = _paymentGateway;
    map['type'] = _type;
    map['uniqueId'] = _uniqueId;
    map['time'] = _time;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['month'] = _month;
    return map;
  }
}

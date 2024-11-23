import 'dart:convert';

LoadWalletModel loadWalletModelFromJson(String str) => LoadWalletModel.fromJson(json.decode(str));
String loadWalletModelToJson(LoadWalletModel data) => json.encode(data.toJson());

class LoadWalletModel {
  LoadWalletModel({
    bool? status,
    String? message,
    Data? data,
    History? history,
  }) {
    _status = status;
    _message = message;
    _data = data;
    _history = history;
  }

  LoadWalletModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _history = json['history'] != null ? History.fromJson(json['history']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
  History? _history;
  LoadWalletModel copyWith({
    bool? status,
    String? message,
    Data? data,
    History? history,
  }) =>
      LoadWalletModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
        history: history ?? _history,
      );
  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;
  History? get history => _history;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    if (_history != null) {
      map['history'] = _history?.toJson();
    }
    return map;
  }
}

History historyFromJson(String str) => History.fromJson(json.decode(str));
String historyToJson(History data) => json.encode(data.toJson());

class History {
  History({
    String? user,
    String? wallet,
    num? amount,
    String? date,
    num? paymentGateway,
    num? type,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) {
    _user = user;
    _wallet = wallet;
    _amount = amount;
    _date = date;
    _paymentGateway = paymentGateway;
    _type = type;
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  History.fromJson(dynamic json) {
    _user = json['user'];
    _wallet = json['wallet'];
    _amount = json['amount'];
    _date = json['date'];
    _paymentGateway = json['paymentGateway'];
    _type = json['type'];
    _id = json['_id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _user;
  String? _wallet;
  num? _amount;
  String? _date;
  num? _paymentGateway;
  num? _type;
  String? _id;
  String? _createdAt;
  String? _updatedAt;
  History copyWith({
    String? user,
    String? wallet,
    num? amount,
    String? date,
    num? paymentGateway,
    num? type,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) =>
      History(
        user: user ?? _user,
        wallet: wallet ?? _wallet,
        amount: amount ?? _amount,
        date: date ?? _date,
        paymentGateway: paymentGateway ?? _paymentGateway,
        type: type ?? _type,
        id: id ?? _id,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get user => _user;
  String? get wallet => _wallet;
  num? get amount => _amount;
  String? get date => _date;
  num? get paymentGateway => _paymentGateway;
  num? get type => _type;
  String? get id => _id;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = _user;
    map['wallet'] = _wallet;
    map['amount'] = _amount;
    map['date'] = _date;
    map['paymentGateway'] = _paymentGateway;
    map['type'] = _type;
    map['_id'] = _id;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
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

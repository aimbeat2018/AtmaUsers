import 'dart:convert';

GetTaxModel getTaxModelFromJson(String str) => GetTaxModel.fromJson(json.decode(str));
String getTaxModelToJson(GetTaxModel data) => json.encode(data.toJson());

class GetTaxModel {
  GetTaxModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetTaxModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
  GetTaxModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      GetTaxModel(
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
    num? tax,
    num? taxPercent,
    num? finalAmount,
  }) {
    _tax = tax;
    _taxPercent = taxPercent;
    _finalAmount = finalAmount;
  }

  Data.fromJson(dynamic json) {
    _tax = json['tax'];
    _taxPercent = json['taxPercent'];
    _finalAmount = json['finalAmount'];
  }
  num? _tax;
  num? _taxPercent;
  num? _finalAmount;
  Data copyWith({
    num? tax,
    num? taxPercent,
    num? finalAmount,
  }) =>
      Data(
        tax: tax ?? _tax,
        taxPercent: taxPercent ?? _taxPercent,
        finalAmount: finalAmount ?? _finalAmount,
      );
  num? get tax => _tax;
  num? get taxPercent => _taxPercent;
  num? get finalAmount => _finalAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tax'] = _tax;
    map['taxPercent'] = _taxPercent;
    map['finalAmount'] = _finalAmount;
    return map;
  }
}

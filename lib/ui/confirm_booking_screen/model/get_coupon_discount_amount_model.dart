import 'dart:convert';

GetCouponDiscountAmountModel getCouponDiscountAmountModelFromJson(String str) =>
    GetCouponDiscountAmountModel.fromJson(json.decode(str));
String getCouponDiscountAmountModelToJson(GetCouponDiscountAmountModel data) => json.encode(data.toJson());

class GetCouponDiscountAmountModel {
  GetCouponDiscountAmountModel({
    bool? status,
    String? message,
    num? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetCouponDiscountAmountModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'];
  }
  bool? _status;
  String? _message;
  num? _data;
  GetCouponDiscountAmountModel copyWith({
    bool? status,
    String? message,
    num? data,
  }) =>
      GetCouponDiscountAmountModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  num? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['data'] = _data;
    return map;
  }
}

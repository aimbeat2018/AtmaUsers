import 'dart:convert';

BuyMembershipModel buyMembershipModelFromJson(String str) =>
    BuyMembershipModel.fromJson(json.decode(str));

String buyMembershipModelToJson(BuyMembershipModel data) =>
    json.encode(data.toJson());

class BuyMembershipModel {
  BuyMembershipModel({int? status, String? message, BuyMembershipData? data}) {
    _status = status;
    _data = data;
    _message = message;
  }

  int? _status;
  BuyMembershipData? _data;
  String? _message;

  BuyMembershipModel copyWith(
          {int? status, String? message, BuyMembershipData? data}) =>
      BuyMembershipModel(
        status: status ?? _status,
        data: data ?? _data,
        message: message ?? _message,
      );

  int? get status => _status;

  String? get message => _message;

  BuyMembershipData? get data => _data;

  BuyMembershipModel.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _data =
        json['data'] != null ? BuyMembershipData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = _status;
    data['message'] = _message;
    if (_data != null) {
      data['data'] = _data!.toJson();
    }
    return data;
  }
}

BuyMembershipData buyMembershipDataFromJson(String str) =>
    BuyMembershipData.fromJson(json.decode(str));

String buyMembershipDataToJson(BuyMembershipData data) =>
    json.encode(data.toJson());

class BuyMembershipData {
  String? _sId;
  String? _packageId;
  String? _userId;
  String? _paymentId;
  String? _buyingDate;
  String? _expiryDate;
  int? _iV;

  BuyMembershipData(
      {String? sId,
      String? packageId,
      String? userId,
      String? paymentId,
      String? buyingDate,
      String? expiryDate,
      int? iV}) {
    _sId = sId;
    _packageId = packageId;
    _userId = userId;
    _paymentId = paymentId;
    _buyingDate = buyingDate;
    _expiryDate = expiryDate;
    _iV = iV;
  }

  BuyMembershipData copyWith(
          {String? sId,
          String? packageId,
          String? userId,
          String? paymentId,
          String? buyingDate,
          String? expiryDate,
          int? iV}) =>
      BuyMembershipData(
        sId: sId ?? _sId,
        packageId: packageId ?? _packageId,
        userId: userId ?? _userId,
        paymentId: paymentId ?? _paymentId,
        buyingDate: buyingDate ?? _buyingDate,
        expiryDate: expiryDate ?? _expiryDate,
        iV: iV ?? _iV,
      );

  String? get sId => _sId;

  String? get packageId => _packageId;

  String? get userId => _userId;

  String? get paymentId => _paymentId;

  String? get buyingDate => _buyingDate;

  String? get expiryDate => _expiryDate;

  int? get iV => _iV;

  BuyMembershipData.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _packageId = json['package_id'];
    _userId = json['user_id'];
    _paymentId = json['payment_id'];
    _buyingDate = json['buying_date'];
    _expiryDate = json['expiry_date'];
    _iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _sId;
    data['package_id'] = _packageId;
    data['user_id'] = _userId;
    data['payment_id'] = _paymentId;
    data['buying_date'] = _buyingDate;
    data['expiry_date'] = _expiryDate;
    data['__v'] = _iV;
    return data;
  }
}

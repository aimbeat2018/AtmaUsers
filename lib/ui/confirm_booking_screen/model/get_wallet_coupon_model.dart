import 'dart:convert';

GetWalletCouponModel getWalletCouponModelFromJson(String str) => GetWalletCouponModel.fromJson(json.decode(str));
String getWalletCouponModelToJson(GetWalletCouponModel data) => json.encode(data.toJson());

class GetWalletCouponModel {
  GetWalletCouponModel({
    bool? status,
    List<CouponData>? couponData,
  }) {
    _status = status;
    _data = couponData;
  }

  GetWalletCouponModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CouponData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<CouponData>? _data;
  GetWalletCouponModel copyWith({
    bool? status,
    List<CouponData>? data,
  }) =>
      GetWalletCouponModel(
        status: status ?? _status,
        couponData: data ?? _data,
      );
  bool? get status => _status;
  List<CouponData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

CouponData dataFromJson(String str) => CouponData.fromJson(json.decode(str));
String dataToJson(CouponData data) => json.encode(data.toJson());

class CouponData {
  CouponData({
    String? id,
    String? code,
    String? title,
    String? description,
    String? expiryDate,
    num? discountPercent,
    num? maxDiscount,
    List<String>? user,
    num? type,
    num? discountType,
    bool? isActive,
    num? minAmountToApply,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _code = code;
    _title = title;
    _description = description;
    _expiryDate = expiryDate;
    _discountPercent = discountPercent;
    _maxDiscount = maxDiscount;
    _user = user;
    _type = type;
    _discountType = discountType;
    _isActive = isActive;
    _minAmountToApply = minAmountToApply;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  CouponData.fromJson(dynamic json) {
    _id = json['_id'];
    _code = json['code'];
    _title = json['title'];
    _description = json['description'];
    _expiryDate = json['expiryDate'];
    _discountPercent = json['discountPercent'];
    _maxDiscount = json['maxDiscount'];
    _user = json['user'] != null ? json['user'].cast<String>() : [];
    _type = json['type'];
    _discountType = json['discountType'];
    _isActive = json['isActive'];
    _minAmountToApply = json['minAmountToApply'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _code;
  String? _title;
  String? _description;
  String? _expiryDate;
  num? _discountPercent;
  num? _maxDiscount;
  List<String>? _user;
  num? _type;
  num? _discountType;
  bool? _isActive;
  num? _minAmountToApply;
  String? _createdAt;
  String? _updatedAt;
  CouponData copyWith({
    String? id,
    String? code,
    String? title,
    String? description,
    String? expiryDate,
    num? discountPercent,
    num? maxDiscount,
    List<String>? user,
    num? type,
    num? discountType,
    bool? isActive,
    num? minAmountToApply,
    String? createdAt,
    String? updatedAt,
  }) =>
      CouponData(
        id: id ?? _id,
        code: code ?? _code,
        title: title ?? _title,
        description: description ?? _description,
        expiryDate: expiryDate ?? _expiryDate,
        discountPercent: discountPercent ?? _discountPercent,
        maxDiscount: maxDiscount ?? _maxDiscount,
        user: user ?? _user,
        type: type ?? _type,
        discountType: discountType ?? _discountType,
        isActive: isActive ?? _isActive,
        minAmountToApply: minAmountToApply ?? _minAmountToApply,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get code => _code;
  String? get title => _title;
  String? get description => _description;
  String? get expiryDate => _expiryDate;
  num? get discountPercent => _discountPercent;
  num? get maxDiscount => _maxDiscount;
  List<String>? get user => _user;
  num? get type => _type;
  num? get discountType => _discountType;
  bool? get isActive => _isActive;
  num? get minAmountToApply => _minAmountToApply;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['code'] = _code;
    map['title'] = _title;
    map['description'] = _description;
    map['expiryDate'] = _expiryDate;
    map['discountPercent'] = _discountPercent;
    map['maxDiscount'] = _maxDiscount;
    map['user'] = _user;
    map['type'] = _type;
    map['discountType'] = _discountType;
    map['isActive'] = _isActive;
    map['minAmountToApply'] = _minAmountToApply;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

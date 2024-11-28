import 'dart:convert';

MembershipPackageModel getMembershipPackageModelFromJson(String str) =>
    MembershipPackageModel.fromJson(json.decode(str));

String getMembershipPackageModelToJson(MembershipPackageModel data) =>
    json.encode(data.toJson());

class MembershipPackageModel {
  MembershipPackageModel({bool? status, List<MembershipData>? data}) {
    _status = status;
    _data = data;
  }

  bool? _status;
  List<MembershipData>? _data;

  MembershipPackageModel copyWith({bool? status, List<MembershipData>? data}) =>
      MembershipPackageModel(
        status: status ?? _status,
        data: data ?? _data,
      );

  bool? get status => _status;

  List<MembershipData>? get data => _data;

  MembershipPackageModel.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = <MembershipData>[];
      json['data'].forEach((v) {
        _data!.add(MembershipData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = _status;
    if (_data != null) {
      data['data'] = _data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

MembershipData getMembershipDataFromJson(String str) =>
    MembershipData.fromJson(json.decode(str));

String getMembershipDataToJson(MembershipData data) =>
    json.encode(data.toJson());

class MembershipData {
  MembershipData(
      {String? sId,
      String? title,
      String? desc,
      int? price,
      int? age,
      String? discount,
      String? validity,
      bool? status,
      bool? isDelete,
      int? iV}) {
    _sId = sId;
    _title = title;
    _desc = desc;
    _price = price;
    _age = age;
    _discount = discount;
    _validity = validity;
    _status = status;
    _isDelete = isDelete;
    _iV = iV;
  }

  String? _sId;
  String? _title;
  String? _desc;
  int? _price;
  int? _age;
  String? _discount;
  String? _validity;
  bool? _status;
  bool? _isDelete;
  int? _iV;

  String? get sId => _sId;

  String? get title => _title;

  String? get desc => _desc;

  int? get price => _price;

  int? get age => _age;

  String? get discount => _discount;

  String? get validity => _validity;

  bool? get status => _status;

  bool? get isDelete => _isDelete;

  int? get iV => _iV;

  MembershipData copyWith(
          {String? sId,
          String? title,
          String? desc,
          int? price,
          int? age,
          String? discount,
          String? validity,
          bool? status,
          bool? isDelete,
          int? iV}) =>
      MembershipData(
        title: title ?? _title,
        desc: desc ?? _desc,
        price: price ?? _price,
        age: age ?? _age,
        discount: discount ?? _discount,
        validity: validity ?? _validity,
        status: status ?? _status,
        isDelete: isDelete ?? _isDelete,
        iV: iV ?? _iV,
      );

  MembershipData.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _title = json['title'];
    _desc = json['desc'];
    _price = json['price'];
    _age = json['age'];
    _discount = json['discount'];
    _validity = json['validity'];
    _status = json['status'];
    _isDelete = json['isDelete'];
    _iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _sId;
    data['title'] = _title;
    data['desc'] = _desc;
    data['price'] = _price;
    data['age'] = _age;
    data['discount'] = _discount;
    data['validity'] = _validity;
    data['status'] = _status;
    data['isDelete'] = _isDelete;
    data['__v'] = _iV;
    return data;
  }
}

import 'dart:convert';

GetMembershipModel getMembershipModelFromJson(String str) =>
    GetMembershipModel.fromJson(json.decode(str));

String getMembershipModelToJson(GetMembershipModel data) =>
    json.encode(data.toJson());

class GetMembershipModel {
  int? _status;
  String? _message;
  GetMembershipData? _data;

  GetMembershipModel({int? status, String? message, GetMembershipData? data}) {
    _status = status;
    _data = data;
    _message = message;
  }

  GetMembershipModel copyWith(
          {int? status, String? message, GetMembershipData? data}) =>
      GetMembershipModel(
        status: status ?? _status,
        data: data ?? _data,
        message: message ?? _message,
      );

  int? get status => _status;

  String? get message => _message;

  GetMembershipData? get data => _data;

  GetMembershipModel.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _data =
        json['data'] != null ? GetMembershipData.fromJson(json['data']) : null;
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

class GetMembershipData {
  String? _userName;
  int? _age;
  String? _sex;
  String? _userContact;
  String? _userEmail;
  String? _membershipId;
  String? _packageId;
  int? _price;
  String? _discount;
  String? _purchaseDate;
  String? _expiryDate;
  String? _title;


  GetMembershipData({
    String? userName,
    int? age,
    String? sex,
    String? userContact,
    String? userEmail,
    String? membershipId,
    String? packageId,
    int? price,
    String? discount,
    String? purchaseDate,
    String? expiryDate,
    String? title,
  }) {
    _userName = userName;
    _age = age;
    _sex = sex;
    _userContact = userContact;
    _userEmail = userEmail;
    _membershipId = membershipId;
    _packageId = packageId;
    _price = price;
    _discount = discount;
    _purchaseDate = purchaseDate;
    _expiryDate = expiryDate;
    _title =  title;
  }

  GetMembershipData copyWith({
    String? userName,
    int? age,
    String? sex,
    String? userContact,
    String? userEmail,
    String? membershipId,
    String? packageId,
    int? price,
    String? discount,
    String? purchaseDate,
    String? expiryDate,
    String? title,
  }) =>
      GetMembershipData(
        userName: userName ?? _userName,
        age: age ?? _age,
        sex: sex ?? _sex,
        userContact: userContact ?? _userContact,
        userEmail: userEmail ?? _userEmail,
        membershipId: membershipId ?? _membershipId,
        packageId: packageId ?? _packageId,
        price: price ?? _price,
        discount: discount ?? _discount,
        purchaseDate: purchaseDate ?? _purchaseDate,
        expiryDate: expiryDate ?? _expiryDate,
        title: title ?? _title,
      );

  String? get userName => _userName;

  int? get age => _age;

  String? get sex => _sex;

  String? get userContact => _userContact;

  String? get userEmail => _userEmail;

  String? get membershipId => _membershipId;

  String? get packageId => _packageId;

  int? get price => _price;

  String? get discount => _discount;

  String? get purchaseDate => _purchaseDate;

  String? get expiryDate => _expiryDate;

  String? get title => _title;

  GetMembershipData.fromJson(Map<String, dynamic> json) {
    _userName = json['user_name'];
    _age = json['age'];
    _sex = json['sex'];
    _userContact = json['user_contact'];
    _userEmail = json['user_email'];
    _membershipId = json['membership_id'];
    _packageId = json['package_id'];
    _price = json['price'];
    _discount = json['discount'];
    _purchaseDate = json['purchase_date'];
    _expiryDate = json['expiry_date'];
    _title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = _userName;
    data['age'] = _age;
    data['sex'] = _sex;
    data['user_contact'] = _userContact;
    data['user_email'] = _userEmail;
    data['membership_id'] = _membershipId;
    data['package_id'] = _packageId;
    data['price'] = _price;
    data['discount'] = _discount;
    data['purchase_date'] = _purchaseDate;
    data['expiry_date'] = _expiryDate;
    data['title'] = _title;
    return data;
  }
}

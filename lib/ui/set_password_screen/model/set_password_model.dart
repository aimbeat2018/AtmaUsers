import 'dart:convert';

SetPasswordModel setPasswordModelFromJson(String str) => SetPasswordModel.fromJson(json.decode(str));
String setPasswordModelToJson(SetPasswordModel data) => json.encode(data.toJson());

class SetPasswordModel {
  SetPasswordModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  SetPasswordModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  SetPasswordModel copyWith({
    bool? status,
    String? message,
  }) =>
      SetPasswordModel(
        status: status ?? _status,
        message: message ?? _message,
      );
  bool? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }
}

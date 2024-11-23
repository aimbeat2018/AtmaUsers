import 'dart:convert';

VerificationOtpModel verificationOtpModelFromJson(String str) => VerificationOtpModel.fromJson(json.decode(str));
String verificationOtpModelToJson(VerificationOtpModel data) => json.encode(data.toJson());

class VerificationOtpModel {
  VerificationOtpModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  VerificationOtpModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  VerificationOtpModel copyWith({
    bool? status,
    String? message,
  }) =>
      VerificationOtpModel(
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

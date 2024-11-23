import 'dart:convert';

GetSavedDoctorModel getSavedDoctorModelFromJson(String str) => GetSavedDoctorModel.fromJson(json.decode(str));
String getSavedDoctorModelToJson(GetSavedDoctorModel data) => json.encode(data.toJson());

class GetSavedDoctorModel {
  GetSavedDoctorModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  GetSavedDoctorModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  GetSavedDoctorModel copyWith({
    bool? status,
    String? message,
  }) =>
      GetSavedDoctorModel(
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

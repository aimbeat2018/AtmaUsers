import 'dart:convert';

CreateWatchHistoryModel createWatchHistoryModelFromJson(String str) => CreateWatchHistoryModel.fromJson(json.decode(str));
String createWatchHistoryModelToJson(CreateWatchHistoryModel data) => json.encode(data.toJson());

class CreateWatchHistoryModel {
  CreateWatchHistoryModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  CreateWatchHistoryModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  CreateWatchHistoryModel copyWith({
    bool? status,
    String? message,
  }) =>
      CreateWatchHistoryModel(
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

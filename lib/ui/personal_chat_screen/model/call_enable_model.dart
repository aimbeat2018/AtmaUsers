import 'dart:convert';

CallEnableModel callEnableModelFromJson(String str) => CallEnableModel.fromJson(json.decode(str));
String callEnableModelToJson(CallEnableModel data) => json.encode(data.toJson());

class CallEnableModel {
  CallEnableModel({
    bool? status,
    String? message,
    bool? callEnable,
    List<String>? time,
  }) {
    _status = status;
    _message = message;
    _callEnable = callEnable;
    _time = time;
  }

  CallEnableModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _callEnable = json['callEnable'];
    _time = json['time'] != null ? json['time'].cast<String>() : [];
  }
  bool? _status;
  String? _message;
  bool? _callEnable;
  List<String>? _time;
  CallEnableModel copyWith({
    bool? status,
    String? message,
    bool? callEnable,
    List<String>? time,
  }) =>
      CallEnableModel(
        status: status ?? _status,
        message: message ?? _message,
        callEnable: callEnable ?? _callEnable,
        time: time ?? _time,
      );
  bool? get status => _status;
  String? get message => _message;
  bool? get callEnable => _callEnable;
  List<String>? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['callEnable'] = _callEnable;
    map['time'] = _time;
    return map;
  }
}

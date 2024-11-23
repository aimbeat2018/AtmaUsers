import 'dart:convert';

ShareCountVideoModel shareCountVideoModelFromJson(String str) => ShareCountVideoModel.fromJson(json.decode(str));
String shareCountVideoModelToJson(ShareCountVideoModel data) => json.encode(data.toJson());

class ShareCountVideoModel {
  ShareCountVideoModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  ShareCountVideoModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  ShareCountVideoModel copyWith({
    bool? status,
    String? message,
  }) =>
      ShareCountVideoModel(
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

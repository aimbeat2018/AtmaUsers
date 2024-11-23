import 'dart:convert';

GetBookingModel getBookingModelFromJson(String str) => GetBookingModel.fromJson(json.decode(str));
String getBookingModelToJson(GetBookingModel data) => json.encode(data.toJson());

class GetBookingModel {
  GetBookingModel({
    bool? status,
    AllSlot? allSlot,
    List<String>? busySlots,
    bool? isOpen,
    String? message,
  }) {
    _status = status;
    _allSlot = allSlot;
    _busySlots = busySlots;
    _isOpen = isOpen;
    _message = message;
  }

  GetBookingModel.fromJson(dynamic json) {
    _status = json['status'];
    _allSlot = json['allSlot'] != null ? AllSlot.fromJson(json['allSlot']) : null;
    _busySlots = json['busySlots'] != null ? json['busySlots'].cast<String>() : [];
    _isOpen = json['isOpen'];
    _message = json['message'];
  }
  bool? _status;
  AllSlot? _allSlot;
  List<String>? _busySlots;
  bool? _isOpen;
  String? _message;
  GetBookingModel copyWith({
    bool? status,
    AllSlot? allSlot,
    List<String>? busySlots,
    bool? isOpen,
    String? message,
  }) =>
      GetBookingModel(
        status: status ?? _status,
        allSlot: allSlot ?? _allSlot,
        busySlots: busySlots ?? _busySlots,
        isOpen: isOpen ?? _isOpen,
        message: message ?? _message,
      );
  bool? get status => _status;
  AllSlot? get allSlot => _allSlot;
  List<String>? get busySlots => _busySlots;
  bool? get isOpen => _isOpen;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_allSlot != null) {
      map['allSlot'] = _allSlot?.toJson();
    }
    map['busySlots'] = _busySlots;
    map['isOpen'] = _isOpen;
    map['message'] = _message;
    return map;
  }
}

AllSlot allSlotFromJson(String str) => AllSlot.fromJson(json.decode(str));
String allSlotToJson(AllSlot data) => json.encode(data.toJson());

class AllSlot {
  AllSlot({
    List<String>? morning,
    List<String>? evening,
  }) {
    _morning = morning;
    _evening = evening;
  }

  AllSlot.fromJson(dynamic json) {
    _morning = json['morning'] != null ? json['morning'].cast<String>() : [];
    _evening = json['evening'] != null ? json['evening'].cast<String>() : [];
  }
  List<String>? _morning;
  List<String>? _evening;
  AllSlot copyWith({
    List<String>? morning,
    List<String>? evening,
  }) =>
      AllSlot(
        morning: morning ?? _morning,
        evening: evening ?? _evening,
      );
  List<String>? get morning => _morning;
  List<String>? get evening => _evening;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['morning'] = _morning;
    map['evening'] = _evening;
    return map;
  }
}

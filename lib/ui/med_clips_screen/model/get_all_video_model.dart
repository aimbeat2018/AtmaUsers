import 'dart:convert';

GetAllVideoModel getAllVideoModelFromJson(String str) => GetAllVideoModel.fromJson(json.decode(str));
String getAllVideoModelToJson(GetAllVideoModel data) => json.encode(data.toJson());

class GetAllVideoModel {
  GetAllVideoModel({
    bool? status,
    String? message,
    List<GetAllVideoData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetAllVideoModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetAllVideoData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<GetAllVideoData>? _data;
  GetAllVideoModel copyWith({
    bool? status,
    String? message,
    List<GetAllVideoData>? data,
  }) =>
      GetAllVideoModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<GetAllVideoData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

GetAllVideoData dataFromJson(String str) => GetAllVideoData.fromJson(json.decode(str));
String dataToJson(GetAllVideoData data) => json.encode(data.toJson());

class GetAllVideoData {
  GetAllVideoData({
    String? id,
    String? description,
    String? videoUrl,
    String? videoImage,
    num? shareCount,
    bool? isLike,
    bool? isCommentAllowed,
    num? totalLikes,
    num? totalComments,
    String? doctorId,
    String? name,
    String? image,
    List<String>? degree,
  }) {
    _id = id;
    _description = description;
    _videoUrl = videoUrl;
    _videoImage = videoImage;
    _shareCount = shareCount;
    _isLike = isLike;
    _isCommentAllowed = isCommentAllowed;
    _totalLikes = totalLikes;
    _totalComments = totalComments;
    _doctorId = doctorId;
    _name = name;
    _image = image;
    _degree = degree;
  }

  GetAllVideoData.fromJson(dynamic json) {
    _id = json['_id'];
    _description = json['description'];
    _videoUrl = json['videoUrl'];
    _videoImage = json['videoImage'];
    _shareCount = json['shareCount'];
    _isLike = json['isLike'];
    _isCommentAllowed = json['isCommentAllowed'];
    _totalLikes = json['totalLikes'];
    _totalComments = json['totalComments'];
    _doctorId = json['doctorId'];
    _name = json['name'];
    _image = json['image'];
    _degree = json['degree'] != null ? json['degree'].cast<String>() : [];
  }
  String? _id;
  String? _description;
  String? _videoUrl;
  String? _videoImage;
  num? _shareCount;
  bool? _isLike;
  bool? _isCommentAllowed;
  num? _totalLikes;
  num? _totalComments;
  String? _doctorId;
  String? _name;
  String? _image;
  List<String>? _degree;
  GetAllVideoData copyWith({
    String? id,
    String? description,
    String? videoUrl,
    String? videoImage,
    num? shareCount,
    bool? isLike,
    bool? isCommentAllowed,
    num? totalLikes,
    num? totalComments,
    String? doctorId,
    String? name,
    String? image,
    List<String>? degree,
  }) =>
      GetAllVideoData(
        id: id ?? _id,
        description: description ?? _description,
        videoUrl: videoUrl ?? _videoUrl,
        videoImage: videoImage ?? _videoImage,
        shareCount: shareCount ?? _shareCount,
        isLike: isLike ?? _isLike,
        isCommentAllowed: isCommentAllowed ?? _isCommentAllowed,
        totalLikes: totalLikes ?? _totalLikes,
        totalComments: totalComments ?? _totalComments,
        doctorId: doctorId ?? _doctorId,
        name: name ?? _name,
        image: image ?? _image,
        degree: degree ?? _degree,
      );
  String? get id => _id;
  String? get description => _description;
  String? get videoUrl => _videoUrl;
  String? get videoImage => _videoImage;
  num? get shareCount => _shareCount;
  bool? get isLike => _isLike;
  bool? get isCommentAllowed => _isCommentAllowed;
  num? get totalLikes => _totalLikes;
  num? get totalComments => _totalComments;
  String? get doctorId => _doctorId;
  String? get name => _name;
  String? get image => _image;
  List<String>? get degree => _degree;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['description'] = _description;
    map['videoUrl'] = _videoUrl;
    map['videoImage'] = _videoImage;
    map['shareCount'] = _shareCount;
    map['isLike'] = _isLike;
    map['isCommentAllowed'] = _isCommentAllowed;
    map['totalLikes'] = _totalLikes;
    map['totalComments'] = _totalComments;
    map['doctorId'] = _doctorId;
    map['name'] = _name;
    map['image'] = _image;
    map['degree'] = _degree;
    return map;
  }
}

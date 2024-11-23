import 'dart:convert';

GetAllDoctorServiceModel getAllDoctorServiceModelFromJson(String str) => GetAllDoctorServiceModel.fromJson(json.decode(str));
String getAllDoctorServiceModelToJson(GetAllDoctorServiceModel data) => json.encode(data.toJson());

class GetAllDoctorServiceModel {
  GetAllDoctorServiceModel({
    bool? status,
    String? message,
    List<GetAllDoctorsService>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetAllDoctorServiceModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetAllDoctorsService.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<GetAllDoctorsService>? _data;
  GetAllDoctorServiceModel copyWith({
    bool? status,
    String? message,
    List<GetAllDoctorsService>? data,
  }) =>
      GetAllDoctorServiceModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<GetAllDoctorsService>? get data => _data;

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

GetAllDoctorsService dataFromJson(String str) => GetAllDoctorsService.fromJson(json.decode(str));
String dataToJson(GetAllDoctorsService data) => json.encode(data.toJson());

class GetAllDoctorsService {
  GetAllDoctorsService({
    String? serviceId,
    String? serviceName,
    List<Doctors>? doctors,
  }) {
    _serviceId = serviceId;
    _serviceName = serviceName;
    _doctors = doctors;
  }

  GetAllDoctorsService.fromJson(dynamic json) {
    _serviceId = json['serviceId'];
    _serviceName = json['serviceName'];
    if (json['doctors'] != null) {
      _doctors = [];
      json['doctors'].forEach((v) {
        _doctors?.add(Doctors.fromJson(v));
      });
    }
  }
  String? _serviceId;
  String? _serviceName;
  List<Doctors>? _doctors;
  GetAllDoctorsService copyWith({
    String? serviceId,
    String? serviceName,
    List<Doctors>? doctors,
  }) =>
      GetAllDoctorsService(
        serviceId: serviceId ?? _serviceId,
        serviceName: serviceName ?? _serviceName,
        doctors: doctors ?? _doctors,
      );
  String? get serviceId => _serviceId;
  String? get serviceName => _serviceName;
  List<Doctors>? get doctors => _doctors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['serviceId'] = _serviceId;
    map['serviceName'] = _serviceName;
    if (_doctors != null) {
      map['doctors'] = _doctors?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Doctors doctorsFromJson(String str) => Doctors.fromJson(json.decode(str));
String doctorsToJson(Doctors data) => json.encode(data.toJson());

class Doctors {
  Doctors({
    String? id,
    num? uniqueId,
    String? name,
    String? image,
    String? email,
    String? password,
    num? age,
    String? mobile,
    String? gender,
    String? dob,
    bool? isBlock,
    String? fcmToken,
    bool? isDelete,
    num? bookingCount,
    num? currentBookingCount,
    num? wallet,
    num? totalWallet,
    List<String>? service,
    num? charge,
    num? commission,
    String? designation,
    List<String>? degree,
    List<String>? language,
    num? experience,
    num? type,
    String? latitude,
    String? longitude,
    String? country,
    String? clinicName,
    String? address,
    List<String>? awards,
    List<String>? expertise,
    String? yourSelf,
    String? education,
    List<String>? experienceDetails,
    num? reviewCount,
    num? rating,
    num? timeSlot,
    bool? isAttend,
    bool? showDialog,
    bool? isBusy,
    bool? isOnline,
    String? callId,
    String? oneSignalId,
    List<Schedule>? schedule,
    String? createdAt,
    String? updatedAt,
    String? countryCode,
    bool? isSaved,
  }) {
    _id = id;
    _uniqueId = uniqueId;
    _name = name;
    _image = image;
    _email = email;
    _password = password;
    _age = age;
    _mobile = mobile;
    _gender = gender;
    _dob = dob;
    _isBlock = isBlock;
    _fcmToken = fcmToken;
    _isDelete = isDelete;
    _bookingCount = bookingCount;
    _currentBookingCount = currentBookingCount;
    _wallet = wallet;
    _totalWallet = totalWallet;
    _service = service;
    _charge = charge;
    _commission = commission;
    _designation = designation;
    _degree = degree;
    _language = language;
    _experience = experience;
    _type = type;
    _latitude = latitude;
    _longitude = longitude;
    _country = country;
    _clinicName = clinicName;
    _address = address;
    _awards = awards;
    _expertise = expertise;
    _yourSelf = yourSelf;
    _education = education;
    _experienceDetails = experienceDetails;
    _reviewCount = reviewCount;
    _rating = rating;
    _timeSlot = timeSlot;
    _isAttend = isAttend;
    _showDialog = showDialog;
    _isBusy = isBusy;
    _isOnline = isOnline;
    _callId = callId;
    _oneSignalId = oneSignalId;
    _schedule = schedule;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _countryCode = countryCode;
    _isSaved = isSaved;
  }

  Doctors.fromJson(dynamic json) {
    _id = json['_id'];
    _uniqueId = json['uniqueId'];
    _name = json['name'];
    _image = json['image'];
    _email = json['email'];
    _password = json['password'];
    _age = json['age'];
    _mobile = json['mobile'];
    _gender = json['gender'];
    _dob = json['dob'];
    _isBlock = json['isBlock'];
    _fcmToken = json['fcmToken'];
    _isDelete = json['isDelete'];
    _bookingCount = json['bookingCount'];
    _currentBookingCount = json['currentBookingCount'];
    _wallet = json['wallet'];
    _totalWallet = json['totalWallet'];
    _service = json['service'] != null ? json['service'].cast<String>() : [];
    _charge = json['charge'];
    _commission = json['commission'];
    _designation = json['designation'];
    _degree = json['degree'] != null ? json['degree'].cast<String>() : [];
    _language = json['language'] != null ? json['language'].cast<String>() : [];
    _experience = json['experience'];
    _type = json['type'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _country = json['country'];
    _clinicName = json['clinicName'];
    _address = json['address'];
    _awards = json['awards'] != null ? json['awards'].cast<String>() : [];
    _expertise = json['expertise'] != null ? json['expertise'].cast<String>() : [];
    _yourSelf = json['yourSelf'];
    _education = json['education'];
    _experienceDetails = json['experienceDetails'] != null ? json['experienceDetails'].cast<String>() : [];
    _reviewCount = json['reviewCount'];
    _rating = json['rating'];
    _timeSlot = json['timeSlot'];
    _isAttend = json['isAttend'];
    _showDialog = json['showDialog'];
    _isBusy = json['isBusy'];
    _isOnline = json['isOnline'];
    _callId = json['callId'];
    _oneSignalId = json['oneSignalId'];
    if (json['schedule'] != null) {
      _schedule = [];
      json['schedule'].forEach((v) {
        _schedule?.add(Schedule.fromJson(v));
      });
    }
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _countryCode = json['countryCode'];
    _isSaved = json['isSaved'];
  }
  String? _id;
  num? _uniqueId;
  String? _name;
  String? _image;
  String? _email;
  String? _password;
  num? _age;
  String? _mobile;
  String? _gender;
  String? _dob;
  bool? _isBlock;
  String? _fcmToken;
  bool? _isDelete;
  num? _bookingCount;
  num? _currentBookingCount;
  num? _wallet;
  num? _totalWallet;
  List<String>? _service;
  num? _charge;
  num? _commission;
  String? _designation;
  List<String>? _degree;
  List<String>? _language;
  num? _experience;
  num? _type;
  String? _latitude;
  String? _longitude;
  String? _country;
  String? _clinicName;
  String? _address;
  List<String>? _awards;
  List<String>? _expertise;
  String? _yourSelf;
  String? _education;
  List<String>? _experienceDetails;
  num? _reviewCount;
  num? _rating;
  num? _timeSlot;
  bool? _isAttend;
  bool? _showDialog;
  bool? _isBusy;
  bool? _isOnline;
  String? _callId;
  String? _oneSignalId;
  List<Schedule>? _schedule;
  String? _createdAt;
  String? _updatedAt;
  String? _countryCode;
  bool? _isSaved;
  Doctors copyWith({
    String? id,
    num? uniqueId,
    String? name,
    String? image,
    String? email,
    String? password,
    num? age,
    String? mobile,
    String? gender,
    String? dob,
    bool? isBlock,
    String? fcmToken,
    bool? isDelete,
    num? bookingCount,
    num? currentBookingCount,
    num? wallet,
    num? totalWallet,
    List<String>? service,
    num? charge,
    num? commission,
    String? designation,
    List<String>? degree,
    List<String>? language,
    num? experience,
    num? type,
    String? latitude,
    String? longitude,
    String? country,
    String? clinicName,
    String? address,
    List<String>? awards,
    List<String>? expertise,
    String? yourSelf,
    String? education,
    List<String>? experienceDetails,
    num? reviewCount,
    num? rating,
    num? timeSlot,
    bool? isAttend,
    bool? showDialog,
    bool? isBusy,
    bool? isOnline,
    String? callId,
    String? oneSignalId,
    List<Schedule>? schedule,
    String? createdAt,
    String? updatedAt,
    String? countryCode,
    bool? isSaved,
  }) =>
      Doctors(
        id: id ?? _id,
        uniqueId: uniqueId ?? _uniqueId,
        name: name ?? _name,
        image: image ?? _image,
        email: email ?? _email,
        password: password ?? _password,
        age: age ?? _age,
        mobile: mobile ?? _mobile,
        gender: gender ?? _gender,
        dob: dob ?? _dob,
        isBlock: isBlock ?? _isBlock,
        fcmToken: fcmToken ?? _fcmToken,
        isDelete: isDelete ?? _isDelete,
        bookingCount: bookingCount ?? _bookingCount,
        currentBookingCount: currentBookingCount ?? _currentBookingCount,
        wallet: wallet ?? _wallet,
        totalWallet: totalWallet ?? _totalWallet,
        service: service ?? _service,
        charge: charge ?? _charge,
        commission: commission ?? _commission,
        designation: designation ?? _designation,
        degree: degree ?? _degree,
        language: language ?? _language,
        experience: experience ?? _experience,
        type: type ?? _type,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        country: country ?? _country,
        clinicName: clinicName ?? _clinicName,
        address: address ?? _address,
        awards: awards ?? _awards,
        expertise: expertise ?? _expertise,
        yourSelf: yourSelf ?? _yourSelf,
        education: education ?? _education,
        experienceDetails: experienceDetails ?? _experienceDetails,
        reviewCount: reviewCount ?? _reviewCount,
        rating: rating ?? _rating,
        timeSlot: timeSlot ?? _timeSlot,
        isAttend: isAttend ?? _isAttend,
        showDialog: showDialog ?? _showDialog,
        isBusy: isBusy ?? _isBusy,
        isOnline: isOnline ?? _isOnline,
        callId: callId ?? _callId,
        oneSignalId: oneSignalId ?? _oneSignalId,
        schedule: schedule ?? _schedule,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        countryCode: countryCode ?? _countryCode,
        isSaved: isSaved ?? _isSaved,
      );
  String? get id => _id;
  num? get uniqueId => _uniqueId;
  String? get name => _name;
  String? get image => _image;
  String? get email => _email;
  String? get password => _password;
  num? get age => _age;
  String? get mobile => _mobile;
  String? get gender => _gender;
  String? get dob => _dob;
  bool? get isBlock => _isBlock;
  String? get fcmToken => _fcmToken;
  bool? get isDelete => _isDelete;
  num? get bookingCount => _bookingCount;
  num? get currentBookingCount => _currentBookingCount;
  num? get wallet => _wallet;
  num? get totalWallet => _totalWallet;
  List<String>? get service => _service;
  num? get charge => _charge;
  num? get commission => _commission;
  String? get designation => _designation;
  List<String>? get degree => _degree;
  List<String>? get language => _language;
  num? get experience => _experience;
  num? get type => _type;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get country => _country;
  String? get clinicName => _clinicName;
  String? get address => _address;
  List<String>? get awards => _awards;
  List<String>? get expertise => _expertise;
  String? get yourSelf => _yourSelf;
  String? get education => _education;
  List<String>? get experienceDetails => _experienceDetails;
  num? get reviewCount => _reviewCount;
  num? get rating => _rating;
  num? get timeSlot => _timeSlot;
  bool? get isAttend => _isAttend;
  bool? get showDialog => _showDialog;
  bool? get isBusy => _isBusy;
  bool? get isOnline => _isOnline;
  String? get callId => _callId;
  String? get oneSignalId => _oneSignalId;
  List<Schedule>? get schedule => _schedule;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get countryCode => _countryCode;
  bool? get isSaved => _isSaved;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['uniqueId'] = _uniqueId;
    map['name'] = _name;
    map['image'] = _image;
    map['email'] = _email;
    map['password'] = _password;
    map['age'] = _age;
    map['mobile'] = _mobile;
    map['gender'] = _gender;
    map['dob'] = _dob;
    map['isBlock'] = _isBlock;
    map['fcmToken'] = _fcmToken;
    map['isDelete'] = _isDelete;
    map['bookingCount'] = _bookingCount;
    map['currentBookingCount'] = _currentBookingCount;
    map['wallet'] = _wallet;
    map['totalWallet'] = _totalWallet;
    map['service'] = _service;
    map['charge'] = _charge;
    map['commission'] = _commission;
    map['designation'] = _designation;
    map['degree'] = _degree;
    map['language'] = _language;
    map['experience'] = _experience;
    map['type'] = _type;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['country'] = _country;
    map['clinicName'] = _clinicName;
    map['address'] = _address;
    map['awards'] = _awards;
    map['expertise'] = _expertise;
    map['yourSelf'] = _yourSelf;
    map['education'] = _education;
    map['experienceDetails'] = _experienceDetails;
    map['reviewCount'] = _reviewCount;
    map['rating'] = _rating;
    map['timeSlot'] = _timeSlot;
    map['isAttend'] = _isAttend;
    map['showDialog'] = _showDialog;
    map['isBusy'] = _isBusy;
    map['isOnline'] = _isOnline;
    map['callId'] = _callId;
    map['oneSignalId'] = _oneSignalId;
    if (_schedule != null) {
      map['schedule'] = _schedule?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['countryCode'] = _countryCode;
    map['isSaved'] = _isSaved;
    return map;
  }
}

Schedule scheduleFromJson(String str) => Schedule.fromJson(json.decode(str));
String scheduleToJson(Schedule data) => json.encode(data.toJson());

class Schedule {
  Schedule({
    String? day,
    String? startTime,
    String? endTime,
    String? breakStartTime,
    String? breakEndTime,
    num? timeSlot,
    String? id,
  }) {
    _day = day;
    _startTime = startTime;
    _endTime = endTime;
    _breakStartTime = breakStartTime;
    _breakEndTime = breakEndTime;
    _timeSlot = timeSlot;
    _id = id;
  }

  Schedule.fromJson(dynamic json) {
    _day = json['day'];
    _startTime = json['startTime'];
    _endTime = json['endTime'];
    _breakStartTime = json['breakStartTime'];
    _breakEndTime = json['breakEndTime'];
    _timeSlot = json['timeSlot'];
    _id = json['_id'];
  }
  String? _day;
  String? _startTime;
  String? _endTime;
  String? _breakStartTime;
  String? _breakEndTime;
  num? _timeSlot;
  String? _id;
  Schedule copyWith({
    String? day,
    String? startTime,
    String? endTime,
    String? breakStartTime,
    String? breakEndTime,
    num? timeSlot,
    String? id,
  }) =>
      Schedule(
        day: day ?? _day,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        breakStartTime: breakStartTime ?? _breakStartTime,
        breakEndTime: breakEndTime ?? _breakEndTime,
        timeSlot: timeSlot ?? _timeSlot,
        id: id ?? _id,
      );
  String? get day => _day;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get breakStartTime => _breakStartTime;
  String? get breakEndTime => _breakEndTime;
  num? get timeSlot => _timeSlot;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = _day;
    map['startTime'] = _startTime;
    map['endTime'] = _endTime;
    map['breakStartTime'] = _breakStartTime;
    map['breakEndTime'] = _breakEndTime;
    map['timeSlot'] = _timeSlot;
    map['_id'] = _id;
    return map;
  }
}

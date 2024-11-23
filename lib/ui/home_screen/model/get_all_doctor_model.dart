import 'dart:convert';

GetAllDoctorModel getAllDoctorModelFromJson(String str) => GetAllDoctorModel.fromJson(json.decode(str));

String getAllDoctorModelToJson(GetAllDoctorModel data) => json.encode(data.toJson());

class GetAllDoctorModel {
  GetAllDoctorModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetAllDoctorModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<Data>? _data;

  GetAllDoctorModel copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      GetAllDoctorModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  List<Data>? get data => _data;

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

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? serviceId,
    String? serviceName,
    List<GetAllDoctors>? doctors,
  }) {
    _serviceId = serviceId;
    _serviceName = serviceName;
    _doctors = doctors;
  }

  Data.fromJson(dynamic json) {
    _serviceId = json['serviceId'];
    _serviceName = json['serviceName'];
    if (json['doctors'] != null) {
      _doctors = [];
      json['doctors'].forEach((v) {
        _doctors?.add(GetAllDoctors.fromJson(v));
      });
    }
  }

  String? _serviceId;
  String? _serviceName;
  List<GetAllDoctors>? _doctors;

  Data copyWith({
    String? serviceId,
    String? serviceName,
    List<GetAllDoctors>? doctors,
  }) =>
      Data(
        serviceId: serviceId ?? _serviceId,
        serviceName: serviceName ?? _serviceName,
        doctors: doctors ?? _doctors,
      );

  String? get serviceId => _serviceId;

  String? get serviceName => _serviceName;

  List<GetAllDoctors>? get doctors => _doctors;

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

GetAllDoctors doctorsFromJson(String str) => GetAllDoctors.fromJson(json.decode(str));

String doctorsToJson(GetAllDoctors data) => json.encode(data.toJson());

class GetAllDoctors {
  GetAllDoctors({
    BankDetails? bankDetails,
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
    String? yourSelf,
    String? education,
    List<String>? experienceDetails,
    num? reviewCount,
    num? rating,
    num? paymentType,
    String? upiId,
    bool? isAttend,
    bool? showDialog,
    List<Schedule>? schedule,
    String? createdAt,
    String? updatedAt,
    List<dynamic>? expertise,
    num? timeSlot,
    String? callId,
    bool? isBusy,
    bool? isOnline,
    String? oneSignalId,
    bool? isSaved,
  }) {
    _bankDetails = bankDetails;
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
    _yourSelf = yourSelf;
    _education = education;
    _experienceDetails = experienceDetails;
    _reviewCount = reviewCount;
    _rating = rating;
    _paymentType = paymentType;
    _upiId = upiId;
    _isAttend = isAttend;
    _showDialog = showDialog;
    _schedule = schedule;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _expertise = expertise;
    _timeSlot = timeSlot;
    _callId = callId;
    _isBusy = isBusy;
    _isOnline = isOnline;
    _oneSignalId = oneSignalId;
    _isSaved = isSaved;
  }

  GetAllDoctors.fromJson(dynamic json) {
    _bankDetails = json['bankDetails'] != null ? BankDetails.fromJson(json['bankDetails']) : null;
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
    _yourSelf = json['yourSelf'];
    _education = json['education'];
    _experienceDetails = json['experienceDetails'] != null ? json['experienceDetails'].cast<String>() : [];
    _reviewCount = json['reviewCount'];
    _rating = json['rating'];
    _paymentType = json['paymentType'];
    _upiId = json['upiId'];
    _isAttend = json['isAttend'];
    _showDialog = json['showDialog'];
    if (json['schedule'] != null) {
      _schedule = [];
      json['schedule'].forEach((v) {
        _schedule?.add(Schedule.fromJson(v));
      });
    }
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _expertise = json['expertise'] ?? [];
    _timeSlot = json['timeSlot'];
    _callId = json['callId'];
    _isBusy = json['isBusy'];
    _isOnline = json['isOnline'];
    _oneSignalId = json['oneSignalId'];
    _isSaved = json['isSaved'];
  }

  BankDetails? _bankDetails;
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
  String? _yourSelf;
  String? _education;
  List<String>? _experienceDetails;
  num? _reviewCount;
  num? _rating;
  num? _paymentType;
  String? _upiId;
  bool? _isAttend;
  bool? _showDialog;
  List<Schedule>? _schedule;
  String? _createdAt;
  String? _updatedAt;
  List<dynamic>? _expertise;
  num? _timeSlot;
  String? _callId;
  bool? _isBusy;
  bool? _isOnline;
  String? _oneSignalId;
  bool? _isSaved;

  GetAllDoctors copyWith({
    BankDetails? bankDetails,
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
    String? yourSelf,
    String? education,
    List<String>? experienceDetails,
    num? reviewCount,
    num? rating,
    num? paymentType,
    String? upiId,
    bool? isAttend,
    bool? showDialog,
    List<Schedule>? schedule,
    String? createdAt,
    String? updatedAt,
    List<dynamic>? expertise,
    num? timeSlot,
    String? callId,
    bool? isBusy,
    bool? isOnline,
    String? oneSignalId,
    bool? isSaved,
  }) =>
      GetAllDoctors(
        bankDetails: bankDetails ?? _bankDetails,
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
        yourSelf: yourSelf ?? _yourSelf,
        education: education ?? _education,
        experienceDetails: experienceDetails ?? _experienceDetails,
        reviewCount: reviewCount ?? _reviewCount,
        rating: rating ?? _rating,
        paymentType: paymentType ?? _paymentType,
        upiId: upiId ?? _upiId,
        isAttend: isAttend ?? _isAttend,
        showDialog: showDialog ?? _showDialog,
        schedule: schedule ?? _schedule,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        expertise: expertise ?? _expertise,
        timeSlot: timeSlot ?? _timeSlot,
        callId: callId ?? _callId,
        isBusy: isBusy ?? _isBusy,
        isOnline: isOnline ?? _isOnline,
        oneSignalId: oneSignalId ?? _oneSignalId,
        isSaved: isSaved ?? _isSaved,
      );

  BankDetails? get bankDetails => _bankDetails;

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

  String? get yourSelf => _yourSelf;

  String? get education => _education;

  List<String>? get experienceDetails => _experienceDetails;

  num? get reviewCount => _reviewCount;

  num? get rating => _rating;

  num? get paymentType => _paymentType;

  String? get upiId => _upiId;

  bool? get isAttend => _isAttend;

  bool? get showDialog => _showDialog;

  List<Schedule>? get schedule => _schedule;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  List<dynamic>? get expertise => _expertise;

  num? get timeSlot => _timeSlot;

  String? get callId => _callId;

  bool? get isBusy => _isBusy;

  bool? get isOnline => _isOnline;

  String? get oneSignalId => _oneSignalId;

  bool? get isSaved => _isSaved;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_bankDetails != null) {
      map['bankDetails'] = _bankDetails?.toJson();
    }
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
    map['yourSelf'] = _yourSelf;
    map['education'] = _education;
    map['experienceDetails'] = _experienceDetails;
    map['reviewCount'] = _reviewCount;
    map['rating'] = _rating;
    map['paymentType'] = _paymentType;
    map['upiId'] = _upiId;
    map['isAttend'] = _isAttend;
    map['showDialog'] = _showDialog;
    if (_schedule != null) {
      map['schedule'] = _schedule?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    if (_expertise != null) {
      map['expertise'] = _expertise?.map((v) => v.toJson()).toList();
    }
    map['timeSlot'] = _timeSlot;
    map['callId'] = _callId;
    map['isBusy'] = _isBusy;
    map['isOnline'] = _isOnline;
    map['oneSignalId'] = _oneSignalId;
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

BankDetails bankDetailsFromJson(String str) => BankDetails.fromJson(json.decode(str));

String bankDetailsToJson(BankDetails data) => json.encode(data.toJson());

class BankDetails {
  BankDetails({
    String? bankName,
    String? accountNumber,
    String? iFSCCode,
    String? branchName,
    String? image,
    String? name,
  }) {
    _bankName = bankName;
    _accountNumber = accountNumber;
    _iFSCCode = iFSCCode;
    _branchName = branchName;
    _image = image;
    _name = name;
  }

  BankDetails.fromJson(dynamic json) {
    _bankName = json['bankName'];
    _accountNumber = json['accountNumber'];
    _iFSCCode = json['IFSCCode'];
    _branchName = json['branchName'];
    _image = json['image'];
    _name = json['name'];
  }

  String? _bankName;
  String? _accountNumber;
  String? _iFSCCode;
  String? _branchName;
  String? _image;
  String? _name;

  BankDetails copyWith({
    String? bankName,
    String? accountNumber,
    String? iFSCCode,
    String? branchName,
    String? image,
    String? name,
  }) =>
      BankDetails(
        bankName: bankName ?? _bankName,
        accountNumber: accountNumber ?? _accountNumber,
        iFSCCode: iFSCCode ?? _iFSCCode,
        branchName: branchName ?? _branchName,
        image: image ?? _image,
        name: name ?? _name,
      );

  String? get bankName => _bankName;

  String? get accountNumber => _accountNumber;

  String? get iFSCCode => _iFSCCode;

  String? get branchName => _branchName;

  String? get image => _image;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bankName'] = _bankName;
    map['accountNumber'] = _accountNumber;
    map['IFSCCode'] = _iFSCCode;
    map['branchName'] = _branchName;
    map['image'] = _image;
    map['name'] = _name;
    return map;
  }
}

import 'dart:convert';
ClientsModel clientsModelFromJson(String str) => ClientsModel.fromJson(json.decode(str));
String clientsModelToJson(ClientsModel data) => json.encode(data.toJson());
class ClientsModel {
  ClientsModel({
      bool? error, 
      List<Data>? data,}){
    _error = error;
    _data = data;
}

  ClientsModel.fromJson(dynamic json) {
    _error = json['error'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  List<Data>? _data;
ClientsModel copyWith({  bool? error,
  List<Data>? data,
}) => ClientsModel(  error: error ?? _error,
  data: data ?? _data,
);
  bool? get error => _error;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
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
      AppointmentId? appointmentId, 
      AdminId? adminId,}){
    _appointmentId = appointmentId;
    _adminId = adminId;
}

  Data.fromJson(dynamic json) {
    _appointmentId = json['appointment_id'] != null ? AppointmentId.fromJson(json['appointment_id']) : null;
    _adminId = json['admin_id'] != null ? AdminId.fromJson(json['admin_id']) : null;
  }
  AppointmentId? _appointmentId;
  AdminId? _adminId;
Data copyWith({  AppointmentId? appointmentId,
  AdminId? adminId,
}) => Data(  appointmentId: appointmentId ?? _appointmentId,
  adminId: adminId ?? _adminId,
);
  AppointmentId? get appointmentId => _appointmentId;
  AdminId? get adminId => _adminId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_appointmentId != null) {
      map['appointment_id'] = _appointmentId?.toJson();
    }
    if (_adminId != null) {
      map['admin_id'] = _adminId?.toJson();
    }
    return map;
  }

}

AdminId adminIdFromJson(String str) => AdminId.fromJson(json.decode(str));
String adminIdToJson(AdminId data) => json.encode(data.toJson());
class AdminId {
  AdminId({
      num? id, 
      num? otpVerifyStatus, 
      String? name, 
      String? phone, 
      dynamic subsStatus, 
      String? subsId, 
      dynamic planId, 
      String? weight, 
      String? height, 
      String? bmi, 
      String? gender, 
      dynamic image, 
      String? email, 
      String? dob, 
      String? city, 
      String? password, 
      String? preference, 
      String? goal, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _otpVerifyStatus = otpVerifyStatus;
    _name = name;
    _phone = phone;
    _subsStatus = subsStatus;
    _subsId = subsId;
    _planId = planId;
    _weight = weight;
    _height = height;
    _bmi = bmi;
    _gender = gender;
    _image = image;
    _email = email;
    _dob = dob;
    _city = city;
    _password = password;
    _preference = preference;
    _goal = goal;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  AdminId.fromJson(dynamic json) {
    _id = json['id'];
    _otpVerifyStatus = json['otp_verify_status'];
    _name = json['name'];
    _phone = json['phone'];
    _subsStatus = json['subs_status'];
    _subsId = json['subs_id'];
    _planId = json['plan_id'];
    _weight = json['weight'];
    _height = json['height'];
    _bmi = json['bmi'];
    _gender = json['gender'];
    _image = json['image'];
    _email = json['email'];
    _dob = json['dob'];
    _city = json['city'];
    _password = json['password'];
    _preference = json['preference'];
    _goal = json['goal'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _otpVerifyStatus;
  String? _name;
  String? _phone;
  dynamic _subsStatus;
  String? _subsId;
  dynamic _planId;
  String? _weight;
  String? _height;
  String? _bmi;
  String? _gender;
  dynamic _image;
  String? _email;
  String? _dob;
  String? _city;
  String? _password;
  String? _preference;
  String? _goal;
  String? _createdAt;
  String? _updatedAt;
AdminId copyWith({  num? id,
  num? otpVerifyStatus,
  String? name,
  String? phone,
  dynamic subsStatus,
  String? subsId,
  dynamic planId,
  String? weight,
  String? height,
  String? bmi,
  String? gender,
  dynamic image,
  String? email,
  String? dob,
  String? city,
  String? password,
  String? preference,
  String? goal,
  String? createdAt,
  String? updatedAt,
}) => AdminId(  id: id ?? _id,
  otpVerifyStatus: otpVerifyStatus ?? _otpVerifyStatus,
  name: name ?? _name,
  phone: phone ?? _phone,
  subsStatus: subsStatus ?? _subsStatus,
  subsId: subsId ?? _subsId,
  planId: planId ?? _planId,
  weight: weight ?? _weight,
  height: height ?? _height,
  bmi: bmi ?? _bmi,
  gender: gender ?? _gender,
  image: image ?? _image,
  email: email ?? _email,
  dob: dob ?? _dob,
  city: city ?? _city,
  password: password ?? _password,
  preference: preference ?? _preference,
  goal: goal ?? _goal,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  num? get otpVerifyStatus => _otpVerifyStatus;
  String? get name => _name;
  String? get phone => _phone;
  dynamic get subsStatus => _subsStatus;
  String? get subsId => _subsId;
  dynamic get planId => _planId;
  String? get weight => _weight;
  String? get height => _height;
  String? get bmi => _bmi;
  String? get gender => _gender;
  dynamic get image => _image;
  String? get email => _email;
  String? get dob => _dob;
  String? get city => _city;
  String? get password => _password;
  String? get preference => _preference;
  String? get goal => _goal;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['otp_verify_status'] = _otpVerifyStatus;
    map['name'] = _name;
    map['phone'] = _phone;
    map['subs_status'] = _subsStatus;
    map['subs_id'] = _subsId;
    map['plan_id'] = _planId;
    map['weight'] = _weight;
    map['height'] = _height;
    map['bmi'] = _bmi;
    map['gender'] = _gender;
    map['image'] = _image;
    map['email'] = _email;
    map['dob'] = _dob;
    map['city'] = _city;
    map['password'] = _password;
    map['preference'] = _preference;
    map['goal'] = _goal;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

AppointmentId appointmentIdFromJson(String str) => AppointmentId.fromJson(json.decode(str));
String appointmentIdToJson(AppointmentId data) => json.encode(data.toJson());
class AppointmentId {
  AppointmentId({
      num? id, 
      String? adminId, 
      String? expertId, 
      String? adminName, 
      String? expertName, 
      String? date, 
      String? time, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _adminId = adminId;
    _expertId = expertId;
    _adminName = adminName;
    _expertName = expertName;
    _date = date;
    _time = time;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  AppointmentId.fromJson(dynamic json) {
    _id = json['id'];
    _adminId = json['admin_id'];
    _expertId = json['expert_id'];
    _adminName = json['admin_name'];
    _expertName = json['expert_name'];
    _date = json['date'];
    _time = json['time'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _adminId;
  String? _expertId;
  String? _adminName;
  String? _expertName;
  String? _date;
  String? _time;
  String? _createdAt;
  String? _updatedAt;
AppointmentId copyWith({  num? id,
  String? adminId,
  String? expertId,
  String? adminName,
  String? expertName,
  String? date,
  String? time,
  String? createdAt,
  String? updatedAt,
}) => AppointmentId(  id: id ?? _id,
  adminId: adminId ?? _adminId,
  expertId: expertId ?? _expertId,
  adminName: adminName ?? _adminName,
  expertName: expertName ?? _expertName,
  date: date ?? _date,
  time: time ?? _time,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get adminId => _adminId;
  String? get expertId => _expertId;
  String? get adminName => _adminName;
  String? get expertName => _expertName;
  String? get date => _date;
  String? get time => _time;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['admin_id'] = _adminId;
    map['expert_id'] = _expertId;
    map['admin_name'] = _adminName;
    map['expert_name'] = _expertName;
    map['date'] = _date;
    map['time'] = _time;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}
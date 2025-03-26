import 'dart:convert';

ConsultedModel consultedModelFromJson(String str) =>
    ConsultedModel.fromJson(json.decode(str));
String consultedModelToJson(ConsultedModel data) => json.encode(data.toJson());

class ConsultedModel {
  ConsultedModel({
    bool? error,
    List<Data>? data,
  }) {
    _error = error;
    _data = data;
  }

  ConsultedModel.fromJson(dynamic json) {
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
  ConsultedModel copyWith({
    bool? error,
    List<Data>? data,
  }) =>
      ConsultedModel(
        error: error ?? _error,
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
    num? id,
    String? name,
    String? email,
    String? phone,
    String? image,
    String? city,
    String? password,
    String? gender,
    String? experience,
    String? specialist,
    String? about,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _phone = phone;
    _image = image;
    _city = city;
    _password = password;
    _gender = gender;
    _experience = experience;
    _specialist = specialist;
    _about = about;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _image = json['image'];
    _city = json['city'];
    _password = json['password'];
    _gender = json['gender'];
    _experience = json['experience'];
    _specialist = json['specialist'];
    _about = json['about'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  String? _email;
  String? _phone;
  String? _image;
  String? _city;
  String? _password;
  String? _gender;
  String? _experience;
  String? _specialist;
  String? _about;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    num? id,
    String? name,
    String? email,
    String? phone,
    String? image,
    String? city,
    String? password,
    String? gender,
    String? experience,
    String? specialist,
    String? about,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? _id,
        name: name ?? _name,
        email: email ?? _email,
        phone: phone ?? _phone,
        image: image ?? _image,
        city: city ?? _city,
        password: password ?? _password,
        gender: gender ?? _gender,
        experience: experience ?? _experience,
        specialist: specialist ?? _specialist,
        about: about ?? _about,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  String? get image => _image;
  String? get city => _city;
  String? get password => _password;
  String? get gender => _gender;
  String? get experience => _experience;
  String? get specialist => _specialist;
  String? get about => _about;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['image'] = _image;
    map['city'] = _city;
    map['password'] = _password;
    map['gender'] = _gender;
    map['experience'] = _experience;
    map['specialist'] = _specialist;
    map['about'] = _about;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

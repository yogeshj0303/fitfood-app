import 'dart:convert';

AboutUsModel aboutUsModelFromJson(String str) =>
    AboutUsModel.fromJson(json.decode(str));
String aboutUsModelToJson(AboutUsModel data) => json.encode(data.toJson());

class AboutUsModel {
  AboutUsModel({
    bool? error,
    List<Data>? data,
  }) {
    _error = error;
    _data = data;
  }

  AboutUsModel.fromJson(dynamic json) {
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
  AboutUsModel copyWith({
    bool? error,
    List<Data>? data,
  }) =>
      AboutUsModel(
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
    String? value,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _value = value;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _value = json['value'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  String? _value;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    num? id,
    String? name,
    String? value,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? _id,
        name: name ?? _name,
        value: value ?? _value,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get name => _name;
  String? get value => _value;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['value'] = _value;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

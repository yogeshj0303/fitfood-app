import 'dart:convert';

CouponModel couponModelFromJson(String str) =>
    CouponModel.fromJson(json.decode(str));
String couponModelToJson(CouponModel data) => json.encode(data.toJson());

class CouponModel {
  CouponModel({
    bool? error,
    List<Data>? data,
  }) {
    _error = error;
    _data = data;
  }

  CouponModel.fromJson(dynamic json) {
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
  CouponModel copyWith({
    bool? error,
    List<Data>? data,
  }) =>
      CouponModel(
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
    int? id,
    String? code,
    String? discount,
    String? amount,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _code = code;
    _discount = discount;
    _amount = amount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _code = json['code'];
    _discount = json['discount'];
    _amount = json['amount'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _code;
  String? _discount;
  String? _amount;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    int? id,
    String? code,
    String? discount,
    String? amount,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? _id,
        code: code ?? _code,
        discount: discount ?? _discount,
        amount: amount ?? _amount,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  int? get id => _id;
  String? get code => _code;
  String? get discount => _discount;
  String? get amount => _amount;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['code'] = _code;
    map['discount'] = _discount;
    map['amount'] = _amount;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

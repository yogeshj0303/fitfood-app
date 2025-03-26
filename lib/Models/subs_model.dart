import 'dart:convert';

SubsModel subsModelFromJson(String str) => SubsModel.fromJson(json.decode(str));
String subsModelToJson(SubsModel data) => json.encode(data.toJson());

class SubsModel {
  SubsModel({
    bool? error,
    List<Data>? data,
  }) {
    _error = error;
    _data = data;
  }

  SubsModel.fromJson(dynamic json) {
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
  SubsModel copyWith({
    bool? error,
    List<Data>? data,
  }) =>
      SubsModel(
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
    String? planId,
    String? planName,
    String? price,
    num? discount,
    String? result,
    String? image,
    String? validity,
    String? des,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _planId = planId;
    _planName = planName;
    _price = price;
    _discount = discount;
    _result = result;
    _image = image;
    _validity = validity;
    _des = des;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _planId = json['plan_id'];
    _planName = json['plan_name'];
    _price = json['price'];
    _discount = json['discount'];
    _result = json['result'];
    _image = json['image'];
    _validity = json['validity'];
    _des = json['des'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _planId;
  String? _planName;
  String? _price;
  num? _discount;
  String? _result;
  String? _image;
  String? _validity;
  String? _des;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    num? id,
    String? planId,
    String? planName,
    String? price,
    num? discount,
    String? result,
    String? image,
    String? validity,
    String? des,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? _id,
        planId: planId ?? _planId,
        planName: planName ?? _planName,
        price: price ?? _price,
        discount: discount ?? _discount,
        result: result ?? _result,
        image: image ?? _image,
        validity: validity ?? _validity,
        des: des ?? _des,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get planId => _planId;
  String? get planName => _planName;
  String? get price => _price;
  num? get discount => _discount;
  String? get result => _result;
  String? get image => _image;
  String? get validity => _validity;
  String? get des => _des;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['plan_id'] = _planId;
    map['plan_name'] = _planName;
    map['price'] = _price;
    map['discount'] = _discount;
    map['result'] = _result;
    map['image'] = _image;
    map['validity'] = _validity;
    map['des'] = _des;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

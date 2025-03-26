import 'dart:convert';

FoodSubCategoryModel foodSubCategoryModelFromJson(String str) =>
    FoodSubCategoryModel.fromJson(json.decode(str));
String foodSubCategoryModelToJson(FoodSubCategoryModel data) =>
    json.encode(data.toJson());

class FoodSubCategoryModel {
  FoodSubCategoryModel({
    bool? error,
    List<Data>? data,
  }) {
    _error = error;
    _data = data;
  }

  FoodSubCategoryModel.fromJson(dynamic json) {
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
  FoodSubCategoryModel copyWith({
    bool? error,
    List<Data>? data,
  }) =>
      FoodSubCategoryModel(
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
    String? categoryId,
    String? mealId,
    String? subcategory,
    String? image,
    String? price,
    String? description,
    dynamic rating,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? mealName,
  }) {
    _id = id;
    _categoryId = categoryId;
    _mealId = mealId;
    _subcategory = subcategory;
    _image = image;
    _price = price;
    _description = description;
    _rating = rating;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _mealName = mealName;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _mealId = json['meal_id'];
    _subcategory = json['subcategory'];
    _image = json['image'];
    _price = json['price'];
    _description = json['description'];
    _rating = json['rating'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _mealName = json['meal_name'];
  }
  num? _id;
  String? _categoryId;
  String? _mealId;
  String? _subcategory;
  String? _image;
  String? _price;
  String? _description;
  dynamic _rating;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _mealName;
  Data copyWith({
    num? id,
    String? categoryId,
    String? mealId,
    String? subcategory,
    String? image,
    String? price,
    String? description,
    dynamic rating,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? mealName,
  }) =>
      Data(
        id: id ?? _id,
        categoryId: categoryId ?? _categoryId,
        mealId: mealId ?? _mealId,
        subcategory: subcategory ?? _subcategory,
        image: image ?? _image,
        price: price ?? _price,
        description: description ?? _description,
        rating: rating ?? _rating,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        mealName: mealName ?? _mealName,
      );
  num? get id => _id;
  String? get categoryId => _categoryId;
  String? get mealId => _mealId;
  String? get subcategory => _subcategory;
  String? get image => _image;
  String? get price => _price;
  String? get description => _description;
  dynamic get rating => _rating;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get mealName => _mealName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['meal_id'] = _mealId;
    map['subcategory'] = _subcategory;
    map['image'] = _image;
    map['price'] = _price;
    map['description'] = _description;
    map['rating'] = _rating;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['meal_name'] = _mealName;
    return map;
  }
}

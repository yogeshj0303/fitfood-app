import 'dart:convert';

ShowOrderModel showOrderModelFromJson(String str) =>
    ShowOrderModel.fromJson(json.decode(str));
String showOrderModelToJson(ShowOrderModel data) => json.encode(data.toJson());

class ShowOrderModel {
  ShowOrderModel({
    bool? error,
    List<Orders>? orders,
  }) {
    _error = error;
    _orders = orders;
  }

  ShowOrderModel.fromJson(dynamic json) {
    _error = json['error'];
    if (json['orders'] != null) {
      _orders = [];
      json['orders'].forEach((v) {
        _orders?.add(Orders.fromJson(v));
      });
    }
  }
  bool? _error;
  List<Orders>? _orders;
  ShowOrderModel copyWith({
    bool? error,
    List<Orders>? orders,
  }) =>
      ShowOrderModel(
        error: error ?? _error,
        orders: orders ?? _orders,
      );
  bool? get error => _error;
  List<Orders>? get orders => _orders;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    if (_orders != null) {
      map['orders'] = _orders?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Orders ordersFromJson(String str) => Orders.fromJson(json.decode(str));
String ordersToJson(Orders data) => json.encode(data.toJson());

class Orders {
  Orders({
    String? orderid,
    String? activeStatus,
    Address? address,
    List<Orderdetails>? orderdetails,
  }) {
    _orderid = orderid;
    _activeStatus = activeStatus;
    _address = address;
    _orderdetails = orderdetails;
  }

  Orders.fromJson(dynamic json) {
    _orderid = json['orderid'];
    _activeStatus = json['active_status'];
    _address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['orderdetails'] != null) {
      _orderdetails = [];
      json['orderdetails'].forEach((v) {
        _orderdetails?.add(Orderdetails.fromJson(v));
      });
    }
  }
  String? _orderid;
  String? _activeStatus;
  Address? _address;
  List<Orderdetails>? _orderdetails;
  Orders copyWith({
    String? orderid,
    String? activeStatus,
    Address? address,
    List<Orderdetails>? orderdetails,
  }) =>
      Orders(
        orderid: orderid ?? _orderid,
        activeStatus: activeStatus ?? _activeStatus,
        address: address ?? _address,
        orderdetails: orderdetails ?? _orderdetails,
      );
  String? get orderid => _orderid;
  String? get activeStatus => _activeStatus;
  Address? get address => _address;
  List<Orderdetails>? get orderdetails => _orderdetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderid'] = _orderid;
    map['active_status'] = _activeStatus;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    if (_orderdetails != null) {
      map['orderdetails'] = _orderdetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Orderdetails orderdetailsFromJson(String str) =>
    Orderdetails.fromJson(json.decode(str));
String orderdetailsToJson(Orderdetails data) => json.encode(data.toJson());

class Orderdetails {
  Orderdetails({
    Details? details,
    String? quantity,
  }) {
    _details = details;
    _quantity = quantity;
  }

  Orderdetails.fromJson(dynamic json) {
    _details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
    _quantity = json['quantity'];
  }
  Details? _details;
  String? _quantity;
  Orderdetails copyWith({
    Details? details,
    String? quantity,
  }) =>
      Orderdetails(
        details: details ?? _details,
        quantity: quantity ?? _quantity,
      );
  Details? get details => _details;
  String? get quantity => _quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_details != null) {
      map['details'] = _details?.toJson();
    }
    map['quantity'] = _quantity;
    return map;
  }
}

Details detailsFromJson(String str) => Details.fromJson(json.decode(str));
String detailsToJson(Details data) => json.encode(data.toJson());

class Details {
  Details({
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
  }

  Details.fromJson(dynamic json) {
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
  Details copyWith({
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
  }) =>
      Details(
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
    return map;
  }
}

Address addressFromJson(String str) => Address.fromJson(json.decode(str));
String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    num? id,
    String? trainerId,
    String? city,
    String? state,
    String? pinCode,
    String? address1,
    String? locality,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _trainerId = trainerId;
    _city = city;
    _state = state;
    _pinCode = pinCode;
    _address1 = address1;
    _locality = locality;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Address.fromJson(dynamic json) {
    _id = json['id'];
    _trainerId = json['trainer_id'];
    _city = json['city'];
    _state = json['state'];
    _pinCode = json['pin_code'];
    _address1 = json['address_1'];
    _locality = json['locality'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _trainerId;
  String? _city;
  String? _state;
  String? _pinCode;
  String? _address1;
  String? _locality;
  String? _createdAt;
  String? _updatedAt;
  Address copyWith({
    num? id,
    String? trainerId,
    String? city,
    String? state,
    String? pinCode,
    String? address1,
    String? locality,
    String? createdAt,
    String? updatedAt,
  }) =>
      Address(
        id: id ?? _id,
        trainerId: trainerId ?? _trainerId,
        city: city ?? _city,
        state: state ?? _state,
        pinCode: pinCode ?? _pinCode,
        address1: address1 ?? _address1,
        locality: locality ?? _locality,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get trainerId => _trainerId;
  String? get city => _city;
  String? get state => _state;
  String? get pinCode => _pinCode;
  String? get address1 => _address1;
  String? get locality => _locality;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['trainer_id'] = _trainerId;
    map['city'] = _city;
    map['state'] = _state;
    map['pin_code'] = _pinCode;
    map['address_1'] = _address1;
    map['locality'] = _locality;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

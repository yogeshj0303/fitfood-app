import 'dart:convert';

ShowOrderModel showOrderModelFromJson(String str) =>
    ShowOrderModel.fromJson(json.decode(str));
String showOrderModelToJson(ShowOrderModel data) => json.encode(data.toJson());

class ShowOrderModel {
  ShowOrderModel({
    bool? success,
    List<OrderData>? data,
  }) {
    _success = success;
    _data = data;
  }

  ShowOrderModel.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(OrderData.fromJson(v));
      });
    }
  }
  bool? _success;
  List<OrderData>? _data;
  ShowOrderModel copyWith({
    bool? success,
    List<OrderData>? data,
  }) =>
      ShowOrderModel(
        success: success ?? _success,
        data: data ?? _data,
      );
  bool? get success => _success;
  List<OrderData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class OrderData {
  OrderData({
    String? orderDetailId,
    Address? address,
    List<OrderProduct>? orderProducts,
  }) {
    _orderDetailId = orderDetailId;
    _address = address;
    _orderProducts = orderProducts;
  }

  OrderData.fromJson(dynamic json) {
    _orderDetailId = json['order_detail_id'];
    _address = json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['order_products'] != null) {
      _orderProducts = [];
      json['order_products'].forEach((v) {
        _orderProducts?.add(OrderProduct.fromJson(v));
      });
    }
  }
  String? _orderDetailId;
  Address? _address;
  List<OrderProduct>? _orderProducts;
  OrderData copyWith({
    String? orderDetailId,
    Address? address,
    List<OrderProduct>? orderProducts,
  }) =>
      OrderData(
        orderDetailId: orderDetailId ?? _orderDetailId,
        address: address ?? _address,
        orderProducts: orderProducts ?? _orderProducts,
      );
  String? get orderDetailId => _orderDetailId;
  Address? get address => _address;
  List<OrderProduct>? get orderProducts => _orderProducts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_detail_id'] = _orderDetailId;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    if (_orderProducts != null) {
      map['order_products'] = _orderProducts?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class OrderProduct {
  OrderProduct({
    String? adminId,
    String? trainerId,
    String? orderid,
    String? quantity,
    String? price,
    String? status,
    String? cartId,
    int? addressId,
    String? orderDate,
    Product? products,
  }) {
    _adminId = adminId;
    _trainerId = trainerId;
    _orderid = orderid;
    _quantity = quantity;
    _price = price;
    _status = status;
    _cartId = cartId;
    _addressId = addressId;
    _orderDate = orderDate;
    _products = products;
  }

  OrderProduct.fromJson(dynamic json) {
    _adminId = json['admin_id'];
    _trainerId = json['trainer_id'];
    _orderid = json['orderid'];
    _quantity = json['quantity'];
    _price = json['price'];
    _status = json['status'];
    _cartId = json['cart_id'];
    _addressId = json['address_id'];
    _orderDate = json['order_date'];
    _products = json['products'] != null ? Product.fromJson(json['products']) : null;
  }
  String? _adminId;
  String? _trainerId;
  String? _orderid;
  String? _quantity;
  String? _price;
  String? _status;
  String? _cartId;
  int? _addressId;
  String? _orderDate;
  Product? _products;

  String? get adminId => _adminId;
  String? get trainerId => _trainerId;
  String? get orderid => _orderid;
  String? get quantity => _quantity;
  String? get price => _price;
  String? get status => _status;
  String? get cartId => _cartId;
  int? get addressId => _addressId;
  String? get orderDate => _orderDate;
  Product? get products => _products;

  // Helper method to get the actual price
  double get actualPrice {
    if (_price == null || _price == "0") {
      return double.tryParse(_products?.price ?? '0') ?? 0;
    }
    return double.tryParse(_price ?? '0') ?? 0;
  }

  // Helper method to get total price for the item
  double get totalPrice {
    final qty = int.tryParse(_quantity ?? '1') ?? 1;
    return actualPrice * qty;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['admin_id'] = _adminId;
    map['trainer_id'] = _trainerId;
    map['orderid'] = _orderid;
    map['quantity'] = _quantity;
    map['price'] = _price;
    map['status'] = _status;
    map['cart_id'] = _cartId;
    map['address_id'] = _addressId;
    map['order_date'] = _orderDate;
    if (_products != null) {
      map['products'] = _products?.toJson();
    }
    return map;
  }
}

class Product {
  Product({
    num? id,
    String? categoryId,
    String? mealId,
    String? subcategory,
    String? image,
    String? price,
    String? quantity,
    String? description,
    dynamic rating,
    String? status,
    String? video,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _categoryId = categoryId;
    _mealId = mealId;
    _subcategory = subcategory;
    _image = image;
    _price = price;
    _quantity = quantity;
    _description = description;
    _rating = rating;
    _status = status;
    _video = video;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _mealId = json['meal_id'];
    _subcategory = json['subcategory'];
    _image = json['image'];
    _price = json['price'];
    _quantity = json['quantity'];
    _description = json['description'];
    _rating = json['rating'];
    _status = json['status'];
    _video = json['video'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _categoryId;
  String? _mealId;
  String? _subcategory;
  String? _image;
  String? _price;
  String? _quantity;
  String? _description;
  dynamic _rating;
  String? _status;
  String? _video;
  String? _createdAt;
  String? _updatedAt;
  Product copyWith({
    num? id,
    String? categoryId,
    String? mealId,
    String? subcategory,
    String? image,
    String? price,
    String? quantity,
    String? description,
    dynamic rating,
    String? status,
    String? video,
    String? createdAt,
    String? updatedAt,
  }) =>
      Product(
        id: id ?? _id,
        categoryId: categoryId ?? _categoryId,
        mealId: mealId ?? _mealId,
        subcategory: subcategory ?? _subcategory,
        image: image ?? _image,
        price: price ?? _price,
        quantity: quantity ?? _quantity,
        description: description ?? _description,
        rating: rating ?? _rating,
        status: status ?? _status,
        video: video ?? _video,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get categoryId => _categoryId;
  String? get mealId => _mealId;
  String? get subcategory => _subcategory;
  String? get image => _image;
  String? get price => _price;
  String? get quantity => _quantity;
  String? get description => _description;
  dynamic get rating => _rating;
  String? get status => _status;
  String? get video => _video;
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
    map['quantity'] = _quantity;
    map['description'] = _description;
    map['rating'] = _rating;
    map['status'] = _status;
    map['video'] = _video;
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
    String? userId,
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
    _userId = userId;
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
    _userId = json['user_id'];
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
  String? _userId;
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
    String? userId,
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
        userId: userId ?? _userId,
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
  String? get userId => _userId;
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
    map['user_id'] = _userId;
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

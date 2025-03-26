import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));
String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    bool? error,
    Data? data,
    String? message,
  }) {
    _error = error;
    _data = data;
    _message = message;
  }

  CartModel.fromJson(dynamic json) {
    _error = json['error'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }
  bool? _error;
  Data? _data;
  String? _message;
  CartModel copyWith({
    bool? error,
    Data? data,
    String? message,
  }) =>
      CartModel(
        error: error ?? _error,
        data: data ?? _data,
        message: message ?? _message,
      );
  bool? get error => _error;
  Data? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    num? productCount,
    num? productMrp,
    String? productPrice,
    List<CartItems>? cartItems,
  }) {
    _productCount = productCount;
    _productMrp = productMrp;
    _productPrice = productPrice;
    _cartItems = cartItems;
  }

  Data.fromJson(dynamic json) {
    _productCount = json['product_count'];
    _productMrp = json['product_mrp'];
    _productPrice = json['product_price'];
    if (json['cart_items'] != null) {
      _cartItems = [];
      json['cart_items'].forEach((v) {
        _cartItems?.add(CartItems.fromJson(v));
      });
    }
  }
  num? _productCount;
  num? _productMrp;
  String? _productPrice;
  List<CartItems>? _cartItems;
  Data copyWith({
    num? productCount,
    num? productMrp,
    String? productPrice,
    List<CartItems>? cartItems,
  }) =>
      Data(
        productCount: productCount ?? _productCount,
        productMrp: productMrp ?? _productMrp,
        productPrice: productPrice ?? _productPrice,
        cartItems: cartItems ?? _cartItems,
      );
  num? get productCount => _productCount;
  num? get productMrp => _productMrp;
  String? get productPrice => _productPrice;
  List<CartItems>? get cartItems => _cartItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_count'] = _productCount;
    map['product_mrp'] = _productMrp;
    map['product_price'] = _productPrice;
    if (_cartItems != null) {
      map['cart_items'] = _cartItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

CartItems cartItemsFromJson(String str) => CartItems.fromJson(json.decode(str));
String cartItemsToJson(CartItems data) => json.encode(data.toJson());

class CartItems {
  CartItems({
    num? id,
    num? subcategorieid,
    String? mrp,
    String? price,
    num? userid,
    num? quantity,
    num? tempDiscount,
    String? createdAt,
    String? updatedAt,
    ProductsDetails? productsDetails,
  }) {
    _id = id;
    _subcategorieid = subcategorieid;
    _mrp = mrp;
    _price = price;
    _userid = userid;
    _quantity = quantity;
    _tempDiscount = tempDiscount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _productsDetails = productsDetails;
  }

  CartItems.fromJson(dynamic json) {
    _id = json['id'];
    _subcategorieid = json['subcategorieid'];
    _mrp = json['mrp'];
    _price = json['price'];
    _userid = json['userid'];
    _quantity = json['quantity'];
    _tempDiscount = json['tempDiscount'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _productsDetails = json['products_details'] != null
        ? ProductsDetails.fromJson(json['products_details'])
        : null;
  }
  num? _id;
  num? _subcategorieid;
  String? _mrp;
  String? _price;
  num? _userid;
  num? _quantity;
  num? _tempDiscount;
  String? _createdAt;
  String? _updatedAt;
  ProductsDetails? _productsDetails;
  CartItems copyWith({
    num? id,
    num? subcategorieid,
    String? mrp,
    String? price,
    num? userid,
    num? quantity,
    num? tempDiscount,
    String? createdAt,
    String? updatedAt,
    ProductsDetails? productsDetails,
  }) =>
      CartItems(
        id: id ?? _id,
        subcategorieid: subcategorieid ?? _subcategorieid,
        mrp: mrp ?? _mrp,
        price: price ?? _price,
        userid: userid ?? _userid,
        quantity: quantity ?? _quantity,
        tempDiscount: tempDiscount ?? _tempDiscount,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        productsDetails: productsDetails ?? _productsDetails,
      );
  num? get id => _id;
  num? get subcategorieid => _subcategorieid;
  String? get mrp => _mrp;
  String? get price => _price;
  num? get userid => _userid;
  num? get quantity => _quantity;
  num? get tempDiscount => _tempDiscount;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  ProductsDetails? get productsDetails => _productsDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['subcategorieid'] = _subcategorieid;
    map['mrp'] = _mrp;
    map['price'] = _price;
    map['userid'] = _userid;
    map['quantity'] = _quantity;
    map['tempDiscount'] = _tempDiscount;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_productsDetails != null) {
      map['products_details'] = _productsDetails?.toJson();
    }
    return map;
  }
}

ProductsDetails productsDetailsFromJson(String str) =>
    ProductsDetails.fromJson(json.decode(str));
String productsDetailsToJson(ProductsDetails data) =>
    json.encode(data.toJson());

class ProductsDetails {
  ProductsDetails({
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

  ProductsDetails.fromJson(dynamic json) {
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
  ProductsDetails copyWith({
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
      ProductsDetails(
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

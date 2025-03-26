import 'dart:convert';
import 'package:fit_food/Constants/export.dart';
import 'package:fit_food/Models/cart_model.dart';
import 'package:fit_food/Models/coupon_model.dart';
import 'package:fit_food/Models/show_order_model.dart';
import 'package:http/http.dart' as http;

import '../Models/trainer_cart_model.dart';

class CartController extends GetxController {
  RxInt cartTotal = 0.obs;
  RxInt discount = 0.obs;
  RxString couponSaving = '0'.obs;
  RxInt amountPayable = 0.obs;
  RxInt cartId = 0.obs;
  RxInt qty = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isCartLoading = false.obs;

  Future<void> addToCart(int productId) async {
    isLoading.value = true;
    final url =
        '${apiUrl}addtocart?user_id=${GlobalVariable.id}&subcategorie_id=$productId&quantity=1';
    final response = await http.post(Uri.parse(url));
    isLoading.value = true;
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        isLoading.value = false;
        Fluttertoast.showToast(msg: data['message']);
      } else {
        isLoading.value = false;
        Fluttertoast.showToast(msg: 'Product is already in cart');
      }
    } else {
      isLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<CartModel> showCart() async {
    final url = '${apiUrl}getCart?user_id=${GlobalVariable.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        return CartModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable to load data');
  }

  Future<void> updateQuantity({required int qty, required int cartId}) async {
    final url =
        '${apiUrl}addCartQuantity?user_id=${GlobalVariable.id}&cart_id=$cartId&quantity=$qty';
    final response = await http.post(Uri.parse(url));
    isCartLoading.value = true;
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        isCartLoading.value = false;
        Get.back();
        Fluttertoast.showToast(msg: 'Updated');
      } else {
        isCartLoading.value = false;
        Fluttertoast.showToast(msg: data['message']);
      }
    } else {
      isCartLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<void> deleteItem({required int cartId}) async {
    final url =
        '${apiUrl}deleteCartItem?user_id=${GlobalVariable.id}&cart_id=$cartId';
    final response = await http.post(Uri.parse(url));
    isCartLoading.value = true;
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        isCartLoading.value = false;
        Get.back();
        Fluttertoast.showToast(msg: 'deleted');
      } else {
        isCartLoading.value = false;
        Fluttertoast.showToast(msg: data['cart']);
      }
    } else {
      isCartLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<CouponModel> showCoupons() async {
    const url = '${apiUrl}showCoupon';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        return CouponModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable to load data');
  }

  Future<void> applyCoupon({required String code}) async {
    final url = '${apiUrl}ApplyCoupon?userid=${GlobalVariable.id}&code=$code';
    final response = await http.post(Uri.parse(url));
    isCartLoading.value = true;
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        isCartLoading.value = false;
        Get.back();
        Fluttertoast.showToast(msg: 'Coupon applied');
      } else {
        isCartLoading.value = false;
        Fluttertoast.showToast(msg: data['message']);
      }
    } else {
      isCartLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<void> placeOrder(
      {required int addressId, required String payMethod}) async {
    final url =
        '${apiUrl}submitOrder?user_id=${GlobalVariable.id}&address_id=$addressId&payment_method=$payMethod';
    final response = await http.post(Uri.parse(url));
    isCartLoading.value = true;
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        isCartLoading.value = false;
        Get.back();
        Fluttertoast.showToast(msg: 'Order Placed');
      } else {
        isCartLoading.value = false;
        Fluttertoast.showToast(msg: data['message']);
      }
    } else {
      isCartLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<ShowOrderModel> showOrders() async {
    final url = '${apiUrl}getOrderData?user_id=${GlobalVariable.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        return ShowOrderModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable to load data');
  }

  Future<void> addToTrainerCart(int productId) async {
    isLoading.value = true;
    final url =
        '${apiUrl}addCart?trainer_id=${GlobalVariable.trainersID}&subcategorie_id=$productId&quantity=1';
    final response = await http.post(Uri.parse(url));
    isLoading.value = true;
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        isLoading.value = false;
        Fluttertoast.showToast(msg: data['message']);
      } else {
        isLoading.value = false;
        Fluttertoast.showToast(msg: 'Product is already in cart');
      }
    } else {
      isLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<void> updateTrainerCartQuantity(
      {required int qty, required int cartId}) async {
    final url =
        '${apiUrl}addCartquantity?trainer_id=${GlobalVariable.trainersID}&cart_id=$cartId&quantity=$qty';
    final response = await http.post(Uri.parse(url));
    isCartLoading.value = true;
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        isCartLoading.value = false;
        Get.back();
        Fluttertoast.showToast(msg: 'Updated');
      } else {
        isCartLoading.value = false;
        Fluttertoast.showToast(msg: data['message']);
      }
    } else {
      isCartLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<TrainerCartModel> showTrainersCart() async {
    final url = '${apiUrl}showCart?trainer_id=${GlobalVariable.trainersID}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        return TrainerCartModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable to load data');
  }

  Future<void> deleteTrainersItem({required int cartId}) async {
    final url =
        '${apiUrl}deleteCart?trainer_id=${GlobalVariable.trainersID}&cart_id=$cartId';
    final response = await http.post(Uri.parse(url));
    isCartLoading.value = true;
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        isCartLoading.value = false;
        Get.back();
        Fluttertoast.showToast(msg: 'deleted');
      } else {
        isCartLoading.value = false;
        Fluttertoast.showToast(msg: data['cart']);
      }
    } else {
      isCartLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<void> applyTrainerCoupon({required String code}) async {
    final url =
        '${apiUrl}applyCoupon?trainer_id=${GlobalVariable.trainersID}&code=$code';
    final response = await http.post(Uri.parse(url));
    isCartLoading.value = true;
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        isCartLoading.value = false;
        Get.back();
        Fluttertoast.showToast(msg: 'Coupon applied');
      } else {
        isCartLoading.value = false;
        Fluttertoast.showToast(msg: data['message']);
      }
    } else {
      isCartLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<void> trainerPlaceOrder(
      {required int addressId, required String payMethod}) async {
    final url =
        '${apiUrl}SubmitTrainerOrder?trainer_id=${GlobalVariable.trainersID}&address_id=$addressId&payment_method=$payMethod';
    final response = await http.post(Uri.parse(url));
    isCartLoading.value = true;
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        isCartLoading.value = false;
        Get.back();
        Fluttertoast.showToast(msg: 'Order Placed');
      } else {
        isCartLoading.value = false;
        Fluttertoast.showToast(msg: data['message']);
      }
    } else {
      isCartLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<ShowOrderModel> showTrainersOrders() async {
    final url = '${apiUrl}getOrderdata?trainer_id=${GlobalVariable.trainersID}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        return ShowOrderModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable to load data');
  }
}

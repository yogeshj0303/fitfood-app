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
  RxBool hasError = false.obs;
  RxString error = ''.obs;

  Rx<ShowOrderModel?> showOrderModel = Rx<ShowOrderModel?>(null);
  final cartData = Rx<CartModel?>(null);
  final trainerCartData = Rx<TrainerCartModel?>(null);

  Future<void> addToCart(int productId) async {
    isLoading.value = true;
    final url =
        '${apiUrl}addtocart?user_id=${GlobalVariable.id}&subcategorie_id=$productId&quantity=${qty.value}';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] == false) {
          isLoading.value = false;
          qty.value = 1; // Reset quantity after adding to cart
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
    } catch (e) {
      isLoading.value = false;
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  Future<CartModel> showCart() async {
    try {
      isCartLoading.value = true;
      final url = '${apiUrl}getCart?user_id=${GlobalVariable.id}';
      final response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] == false) {
          final result = CartModel.fromJson(data);
          cartData.value = result;

          // Set the cart total and payable amount
          if (result.data != null) {
            cartTotal.value = result.data!.productMrp?.toInt() ?? 0;
            amountPayable.value =
                int.tryParse(result.data!.productPrice ?? '0') ?? 0;
            couponSaving.value =
                (cartTotal.value - amountPayable.value).toString();
          }

          return result;
        }
        throw Exception(data['message'] ?? 'Something went wrong');
      }
      throw Exception('${response.statusCode} ${response.reasonPhrase}');
    } catch (e) {
      hasError.value = true;
      error.value = e.toString();
      rethrow;
    } finally {
      isCartLoading.value = false;
    }
  }

  Future<void> updateQuantity({required int qty, required int cartId}) async {
    isCartLoading.value = true;
    final url =
        '${apiUrl}addCartQuantity?user_id=${GlobalVariable.id}&cart_id=$cartId&quantity=$qty';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] == false) {
          isCartLoading.value = false;
          Get.back();
          // Refresh cart data after successful update
          await showCart();
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
    } catch (e) {
      isCartLoading.value = false;
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  Future<void> deleteItem({required int cartId}) async {
    try {
      isCartLoading.value = true;
      final url =
          '${apiUrl}deleteCartItem?user_id=${GlobalVariable.id}&cart_id=$cartId';
      final response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] == false) {
          // Refresh cart data
          await showCart();
          Fluttertoast.showToast(msg: 'Item removed from cart');
        } else {
          throw Exception(data['message'] ?? 'Failed to remove item');
        }
      }
    } catch (e) {
      hasError.value = true;
      error.value = e.toString();
      Fluttertoast.showToast(msg: 'Error removing item');
    } finally {
      isCartLoading.value = false;
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
    isCartLoading.value = true;
    final url = '${apiUrl}ApplyCoupon?userid=${GlobalVariable.id}&code=$code';
    try {
      final response = await http.post(Uri.parse(url));
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
    } catch (e) {
      isCartLoading.value = false;
      Fluttertoast.showToast(msg: 'Error: $e');
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
    isLoading.value = true;
    try {
      final url = '${apiUrl}getOrderData?user_id=${GlobalVariable.id}';
      final response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final result = ShowOrderModel.fromJson(data);
          showOrderModel.value = result;
          return result;
        }
        throw Exception(data['message'] ?? 'Something went wrong');
      }
      throw Exception('${response.statusCode} ${response.reasonPhrase}');
    } catch (e) {
      hasError.value = true;
      error.value = e.toString();
      Fluttertoast.showToast(msg: e.toString());
      throw Exception('Unable to load data');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToTrainerCart(int productId) async {
    isLoading.value = true;
    final url =
        '${apiUrl}addCart?trainer_id=${GlobalVariable.trainersID}&subcategorie_id=$productId&quantity=${qty.value}';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] == false) {
          isLoading.value = false;
          qty.value = 1; // Reset quantity after adding to cart
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
    } catch (e) {
      isLoading.value = false;
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  Future<void> updateTrainerCartQuantity(
      {required int qty, required int cartId}) async {
    isCartLoading.value = true;
    final url =
        '${apiUrl}addCartquantity?trainer_id=${GlobalVariable.trainersID}&cart_id=$cartId&quantity=$qty';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] == false) {
          isCartLoading.value = false;
          Get.back();
          // Refresh cart data after successful update
          await showTrainersCart();
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
    } catch (e) {
      isCartLoading.value = false;
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  Future<TrainerCartModel> showTrainersCart() async {
    try {
      final url = '${apiUrl}showCart?trainer_id=${GlobalVariable.trainersID}';
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] == false) {
          final result = TrainerCartModel.fromJson(data);
          trainerCartData.value = result;
          return result;
        }
        throw Exception('something went wrong');
      }
      throw Exception('${response.statusCode} ${response.reasonPhrase}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTrainersItem({required int cartId}) async {
    try {
      isCartLoading.value = true;
      final url =
          '${apiUrl}deleteCart?trainer_id=${GlobalVariable.trainersID}&cart_id=$cartId';
      final response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] == false) {
          // Refresh cart data
          await showTrainersCart();
          Fluttertoast.showToast(msg: 'Item removed from cart');
        } else {
          throw Exception(data['message'] ?? 'Failed to remove item');
        }
      }
    } catch (e) {
      hasError.value = true;
      error.value = e.toString();
      Fluttertoast.showToast(msg: 'Error removing item');
    } finally {
      isCartLoading.value = false;
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

  Future<ShowOrderModel?> showTrainersOrders() async {
    try {
      isLoading.value = true;
      final url =
          '${apiUrl}getOrderdata?trainer_id=${GlobalVariable.trainersID}';
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] == false) {
          showOrderModel.value = ShowOrderModel.fromJson(data);
        } else {
          error.value = data['message'] ?? "Something went wrong";
          hasError.value = true;
        }
      } else {
        Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      throw Exception('Unable to load data');
    } finally {
      isLoading.value = false;
    }
    return null;
  }
}

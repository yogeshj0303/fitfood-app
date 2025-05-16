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
        print('Debug - Cart API Response: $data');
        
        if (data['error'] == false) {
          final result = CartModel.fromJson(data);
          cartData.value = result;

          // Set the cart total and payable amount
          if (result.data != null) {
            // Get the MRP from the API response
            final mrp = result.data!.productMrp?.toInt() ?? 0;
            print('Debug - Cart MRP: $mrp');
            
            // Always set cart total to MRP
            cartTotal.value = mrp;
            
            // If there's no coupon applied, amount payable equals cart total
            if (couponSaving.value == '0') {
              amountPayable.value = mrp;
            } else {
              // If there is a coupon, use the discounted price
              amountPayable.value = int.tryParse(result.data!.productPrice ?? '0') ?? mrp;
            }

            // Force UI update
            cartTotal.refresh();
            amountPayable.refresh();
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
    try {
      // First remove any existing coupon
      await removeCoupon();
      
      // Then update the quantity
      final url =
          '${apiUrl}addCartQuantity?user_id=${GlobalVariable.id}&cart_id=$cartId&quantity=$qty';
      final response = await http.post(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] == false) {
          // Reset coupon savings to 0
          couponSaving.value = '0';
          // Force UI update
          couponSaving.refresh();
          
          // Get the updated cart data
          final updatedCart = await showCart();
          if (updatedCart.data != null) {
            // Set both cart total and amount payable to MRP
            final mrp = updatedCart.data!.productMrp!.toInt();
            cartTotal.value = mrp;
            amountPayable.value = mrp;
            // Force UI updates
            cartTotal.refresh();
            amountPayable.refresh();
          }
          
          isCartLoading.value = false;
          Get.back();
          Fluttertoast.showToast(msg: 'Quantity updated. Please reapply coupon if needed.');
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
          // Remove coupon when item is deleted
          await removeCoupon();
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
    try {
      // First get the cart total to check minimum order amount
      final cartResult = await showCart();
      if (cartResult.data == null) {
        isCartLoading.value = false;
        Fluttertoast.showToast(msg: 'Unable to fetch cart data');
        return;
      }

      // Validate cart total
      final currentTotal = cartTotal.value;
      print('Debug - Current Cart Total: $currentTotal');
      
      if (currentTotal <= 0) {
        isCartLoading.value = false;
        Fluttertoast.showToast(msg: 'Invalid cart total');
        return;
      }
      
      // Get coupon details to check minimum amount
      final coupons = await showCoupons();
      if (coupons.data == null || coupons.data!.isEmpty) {
        isCartLoading.value = false;
        Fluttertoast.showToast(msg: 'No coupons available');
        return;
      }
      
      final coupon = coupons.data?.firstWhere((c) => c.code == code);
      if (coupon == null) {
        isCartLoading.value = false;
        Fluttertoast.showToast(msg: 'Invalid coupon code');
        return;
      }

      // Validate coupon data
      if (coupon.amount == null || coupon.discount == null) {
        isCartLoading.value = false;
        Fluttertoast.showToast(msg: 'Invalid coupon data');
        return;
      }

      final minAmount = int.tryParse(coupon.amount!) ?? 0;
      print('Debug - Minimum Amount Required: $minAmount');
      
      if (minAmount <= 0) {
        isCartLoading.value = false;
        Fluttertoast.showToast(msg: 'Invalid minimum amount in coupon');
        return;
      }

      // Ensure we're comparing integers
      if (currentTotal < minAmount) {
        isCartLoading.value = false;
        Fluttertoast.showToast(msg: 'Minimum order amount of ₹$minAmount required for this coupon. Your cart total is ₹$currentTotal');
        return;
      }

      // Calculate discount based on total cart amount
      final discountPercentage = int.tryParse(coupon.discount!) ?? 0;
      if (discountPercentage <= 0) {
        isCartLoading.value = false;
        Fluttertoast.showToast(msg: 'Invalid discount percentage');
        return;
      }

      final discountAmount = (currentTotal * discountPercentage / 100).round();
      print('Debug - Discount Calculation: $currentTotal * $discountPercentage% = $discountAmount');
      
      // Apply coupon to total cart amount
      final url = '${apiUrl}ApplyCoupon?userid=${GlobalVariable.id}&code=$code';
      print('Debug - API URL: $url');
      
      final response = await http.post(Uri.parse(url));
      print('Debug - API Response Status: ${response.statusCode}');
      print('Debug - API Response Body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Debug - Parsed Response: $data');
        
        if (data['error'] == false) {
          // Set the discount amount based on total cart value
          couponSaving.value = discountAmount.toString();
          // Refresh cart data to show updated prices
          await showCart();
          isCartLoading.value = false;
          Get.back();
          Fluttertoast.showToast(msg: 'Coupon applied successfully');
        } else {
          isCartLoading.value = false;
          final errorMsg = data['message'] ?? 'Failed to apply coupon';
          print('Debug - Error Message: $errorMsg');
          Fluttertoast.showToast(msg: errorMsg);
        }
      } else {
        isCartLoading.value = false;
        final errorMsg = 'Server error: ${response.statusCode} ${response.reasonPhrase}';
        print('Debug - $errorMsg');
        Fluttertoast.showToast(msg: errorMsg);
      }
    } catch (e, stackTrace) {
      isCartLoading.value = false;
      print('Debug - Error: $e');
      print('Debug - Stack Trace: $stackTrace');
      Fluttertoast.showToast(msg: 'Error applying coupon: $e');
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
    try {
      // First remove any existing coupon
      await removeTrainerCoupon();
      
      // Then update the quantity
      final url =
          '${apiUrl}addCartquantity?trainer_id=${GlobalVariable.trainersID}&cart_id=$cartId&quantity=$qty';
      final response = await http.post(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] == false) {
          // Reset coupon savings to 0
          couponSaving.value = '0';
          // Force UI update
          couponSaving.refresh();
          
          // Get the updated cart data
          final updatedCart = await showTrainersCart();
          if (updatedCart.data != null) {
            // Set both cart total and amount payable to MRP
            final mrp = updatedCart.data!.productMrp!.toInt();
            cartTotal.value = mrp;
            amountPayable.value = mrp;
            // Force UI updates
            cartTotal.refresh();
            amountPayable.refresh();
          }
          
          isCartLoading.value = false;
          Get.back();
          Fluttertoast.showToast(msg: 'Quantity updated. Please reapply coupon if needed.');
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

          // Set the cart total and payable amount
          if (result.data != null) {
            // Get the MRP from the API response
            final mrp = result.data!.productMrp?.toInt() ?? 0;
            
            // Always set cart total to MRP
            cartTotal.value = mrp;
            
            // If there's no coupon applied, amount payable equals cart total
            if (couponSaving.value == '0') {
              amountPayable.value = mrp;
            } else {
              // If there is a coupon, use the discounted price
              amountPayable.value = result.data!.productPrice?.toInt() ?? mrp;
            }

            // Force UI update
            cartTotal.refresh();
            amountPayable.refresh();
          }

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
          // Remove coupon when item is deleted
          await removeTrainerCoupon();
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
    isCartLoading.value = true;
    try {
      // First get the cart total to check minimum order amount
      await showTrainersCart();
      
      // Get coupon details to check minimum amount
      final coupons = await showCoupons();
      final coupon = coupons.data?.firstWhere((c) => c.code == code);
      
      if (coupon != null) {
        final minAmount = int.tryParse(coupon.amount ?? '0') ?? 0;
        if (cartTotal.value < minAmount) {
          isCartLoading.value = false;
          Fluttertoast.showToast(msg: 'Minimum order amount of ₹$minAmount required for this coupon');
          return;
        }

        // Calculate discount based on single item price
        final discountPercentage = int.tryParse(coupon.discount ?? '0') ?? 0;
        // Get the base price of a single item
        final basePrice = int.tryParse(trainerCartData.value?.data?.cartItems?.first.price ?? '0') ?? 0;
        final discountAmount = (basePrice * discountPercentage / 100).round();
        
        // Apply coupon to total cart amount
        final url =
            '${apiUrl}applyCoupon?trainer_id=${GlobalVariable.trainersID}&code=$code';
        final response = await http.post(Uri.parse(url));
        
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['error'] == false) {
            // Set the fixed discount amount
            couponSaving.value = discountAmount.toString();
            // Refresh cart data to show updated prices
            await showTrainersCart();
            isCartLoading.value = false;
            Get.back();
            Fluttertoast.showToast(msg: 'Coupon applied successfully');
          } else {
            isCartLoading.value = false;
            Fluttertoast.showToast(msg: data['message']);
          }
        } else {
          isCartLoading.value = false;
          Fluttertoast.showToast(
              msg: '${response.statusCode} ${response.reasonPhrase}');
        }
      } else {
        isCartLoading.value = false;
        Fluttertoast.showToast(msg: 'Invalid coupon code');
      }
    } catch (e) {
      isCartLoading.value = false;
      Fluttertoast.showToast(msg: 'Error: $e');
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

  Future<void> removeCoupon() async {
    try {
      final url = '${apiUrl}removeCoupon?userid=${GlobalVariable.id}';
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] == false) {
          // Reset coupon savings to 0
          couponSaving.value = '0';
          // Force UI update
          couponSaving.refresh();
          
          // Refresh cart to update prices
          final updatedCart = await showCart();
          if (updatedCart.data != null) {
            // Set cart total and amount payable to be the same (no coupon)
            cartTotal.value = updatedCart.data!.productMrp!.toInt();
            amountPayable.value = updatedCart.data!.productMrp!.toInt();
            // Force UI updates
            cartTotal.refresh();
            amountPayable.refresh();
          }
        }
      }
    } catch (e) {
      print('Error removing coupon: $e');
    }
  }

  Future<void> removeTrainerCoupon() async {
    try {
      final url = '${apiUrl}removeCoupon?trainer_id=${GlobalVariable.trainersID}';
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] == false) {
          // Reset coupon savings to 0
          couponSaving.value = '0';
          // Force UI update
          couponSaving.refresh();
          
          // Refresh cart to update prices
          final updatedCart = await showTrainersCart();
          if (updatedCart.data != null) {
            // Set cart total and amount payable to be the same (no coupon)
            cartTotal.value = updatedCart.data!.productMrp!.toInt();
            amountPayable.value = updatedCart.data!.productMrp!.toInt();
            // Force UI updates
            cartTotal.refresh();
            amountPayable.refresh();
          }
        }
      }
    } catch (e) {
      print('Error removing coupon: $e');
    }
  }
}

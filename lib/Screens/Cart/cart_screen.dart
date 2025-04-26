import 'package:fit_food/Models/trainer_cart_model.dart';
import 'package:fit_food/Screens/Cart/cart_product_card.dart';
import 'package:fit_food/Screens/Cart/show_coupon.dart';
import 'package:fit_food/Screens/Profile/saved_address.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../../Constants/export.dart';
import '../../Components/cart_controller.dart';
import '../../Models/cart_model.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final c = Get.find<CartController>();
  final controller = Get.find<GetController>();

  @override
  void initState() {
    super.initState();
    _loadCartData();
  }

  Future<void> _loadCartData() async {
    try {
      if (controller.role.value == 'Trainer') {
        await c.showTrainersCart();
      } else {
        await c.showCart();
      }
    } catch (e) {
      print('Error loading cart: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        backgroundColor:
            controller.isDarkTheme.value ? Colors.grey[900] : Colors.white,
        appBar: _buildAppBar(),
        body: c.isCartLoading.value
            ? const Center(child: CircularProgressIndicator())
            : c.hasError.value
                ? Center(child: Text(c.error.value))
                : controller.role.value == 'Trainer'
                    ? _buildTrainerCart(size)
                    : _buildUserCart(size),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: controller.isDarkTheme.value ? 0 : 1,
      centerTitle: true,
      backgroundColor:
          controller.isDarkTheme.value ? Colors.grey[850] : Colors.white,
      title: Text(
        'Your Cart',
        style: TextStyle(
          color: controller.isDarkTheme.value ? Colors.white : Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTrainerCart(Size size) {
    return Obx(() {
      if (c.trainerCartData.value == null ||
          c.trainerCartData.value?.data?.cartItems?.isEmpty == true) {
        return noProduct(size);
      }

      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: SizedBox(
              height: size.height * 0.58,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount:
                    c.trainerCartData.value?.data?.cartItems?.length ?? 0,
                itemBuilder: (context, index) => TrainersCartProductCard(
                  snapshot: c.trainerCartData.value!,
                  index: index,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: buildTrainersPaymentCard(c.trainerCartData.value!),
          ),
        ],
      );
    });
  }

  Widget _buildUserCart(Size size) {
    return Obx(() {
      if (c.cartData.value == null ||
          c.cartData.value?.data?.cartItems?.isEmpty == true) {
        return noProduct(size);
      }

      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: SizedBox(
              height: size.height * 0.58,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: c.cartData.value?.data?.cartItems?.length ?? 0,
                itemBuilder: (context, index) => CartProductCard(
                  model: c.cartData.value!,
                  index: index,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: buildPaymentCard(c.cartData.value!),
          ),
        ],
      );
    });
  }

  // Update the payment card methods to use the model directly instead of AsyncSnapshot
  Container buildPaymentCard(CartModel model) {
    c.cartTotal.value = model.data!.productMrp!.toInt();
    c.amountPayable.value = int.parse(model.data!.productPrice!);
    c.couponSaving.value =
        (model.data!.productMrp!.toInt() - int.parse(model.data!.productPrice!))
            .toString();
    return Container(
      decoration: BoxDecoration(
        color: controller.isDarkTheme.value ? Colors.grey[850] : Colors.white,
        boxShadow: [
          BoxShadow(
            color: controller.isDarkTheme.value
                ? Colors.black12
                : Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => Get.to(() => ShowCoupons()),
            child: Container(
              color: controller.isDarkTheme.value
                  ? Colors.green.shade900
                  : Colors.green.shade100,
              padding: const EdgeInsets.all(defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.loyalty,
                      size: 25,
                      color: controller.isDarkTheme.value
                          ? Colors.white
                          : primaryColor),
                  const SizedBox(width: 8),
                  Text(
                    'Apply Coupons',
                    style: TextStyle(
                      color: controller.isDarkTheme.value
                          ? Colors.white
                          : primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            'Order Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color:
                  controller.isDarkTheme.value ? Colors.white : Colors.black87,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cart Total',
                style: TextStyle(
                    color: controller.isDarkTheme.value
                        ? Colors.white70
                        : Colors.black54),
              ),
              Text(
                '₹${c.cartTotal.value}.00',
                style: TextStyle(
                    color: controller.isDarkTheme.value
                        ? Colors.white
                        : Colors.black87),
              ),
            ],
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Coupon Savings', style: Style.normalLightTextStyle),
                Text(
                  '-₹${c.couponSaving.value}',
                  style: Style.smallColortextStyle,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Amount Payable',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                '₹${model.data!.productPrice!}.00',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 40),
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding, horizontal: defaultPadding * 2),
            ),
            onPressed: () => Get.to(() => const SavedAddress(forOrder: true)),
            child: Text(
              'Proceed to payment',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildTrainersPaymentCard(TrainerCartModel model) {
    c.cartTotal.value = model.data!.productMrp!.toInt();
    c.amountPayable.value = model.data!.productPrice!.toInt();
    c.couponSaving.value =
        (model.data!.productMrp!.toInt() - model.data!.productPrice!.toInt())
            .toString();
    return Container(
      decoration: BoxDecoration(
        color: controller.isDarkTheme.value ? Colors.grey[850] : Colors.white,
        boxShadow: [
          BoxShadow(
            color: controller.isDarkTheme.value
                ? Colors.black12
                : Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => Get.to(() => ShowCoupons()),
            child: Container(
              color: controller.isDarkTheme.value
                  ? Colors.green.shade900
                  : Colors.green.shade100,
              padding: const EdgeInsets.all(defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.loyalty,
                      size: 25,
                      color: controller.isDarkTheme.value
                          ? Colors.white
                          : primaryColor),
                  const SizedBox(width: 8),
                  Text(
                    'Apply Coupons',
                    style: TextStyle(
                      color: controller.isDarkTheme.value
                          ? Colors.white
                          : primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            'Order Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color:
                  controller.isDarkTheme.value ? Colors.white : Colors.black87,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cart Total',
                style: TextStyle(
                    color: controller.isDarkTheme.value
                        ? Colors.white70
                        : Colors.black54),
              ),
              Text(
                '₹${c.cartTotal.value}.00',
                style: TextStyle(
                    color: controller.isDarkTheme.value
                        ? Colors.white
                        : Colors.black87),
              ),
            ],
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Coupon Savings', style: Style.normalLightTextStyle),
                Text(
                  '-₹${c.couponSaving.value}',
                  style: Style.smallColortextStyle,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Amount Payable',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                '₹${model.data!.productPrice!}.00',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding, horizontal: defaultPadding * 2),
            ),
            onPressed: () => Get.to(() => const SavedAddress(forOrder: true)),
            child: Text(
              'Proceed to payment',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column noProduct(Size size) {
    return Column(
      children: [
        Container(
          width: size.width,
          padding: const EdgeInsets.all(defaultPadding),
          child: Lottie.asset(cartLottie, height: 275, fit: BoxFit.cover),
        ),
        const SizedBox(height: 55),
        Text(
          'No Products in your Cart',
          style: TextStyle(
            fontSize: 18,
            color: controller.isDarkTheme.value ? Colors.white70 : Colors.grey,
          ),
        )
      ],
    );
  }
}

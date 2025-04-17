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
    return Scaffold(
      backgroundColor: bgColor,
      appBar: _buildAppBar(),
      body: Obx(() {
        if (c.isCartLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (c.hasError.value) {
          return Center(child: Text(c.error.value));
        }

        return controller.role.value == 'Trainer'
            ? _buildTrainerCart(size)
            : _buildUserCart(size);
      }),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 1,
      centerTitle: true,
      backgroundColor: controller.isDarkTheme.value ? blackColor : whiteColor,
      foregroundColor: controller.isDarkTheme.value ? whiteColor : blackColor,
      title: const Text('Your Cart'),
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
      color: whiteColor,
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => Get.to(() => ShowCoupons()),
            child: Container(
              color: Colors.green.shade100,
              padding: const EdgeInsets.all(defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.loyalty, size: 25, color: primaryColor),
                  const SizedBox(width: 8),
                  Text('Apply Coupons', style: Style.smallGreentext)
                ],
              ),
            ),
          ),
          const Text(
            'Order Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Cart Total', style: Style.normalLightTextStyle),
              Text(
                '₹${c.cartTotal.value}.00',
                style: Style.normalTextStyle,
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
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.isDarkTheme.value
                      ? primaryColor
                      : primaryColor,
                  padding: const EdgeInsets.symmetric(
                      vertical: defaultPadding, horizontal: defaultPadding * 2),
                ),
                onPressed: () =>
                    Get.to(() => const SavedAddress(forOrder: true)),
                child: Text(
                  'Proceed to payment',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: controller.isDarkTheme.value
                          ? whiteColor
                          : whiteColor),
                  textAlign: TextAlign.center,
                )),
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
      color: whiteColor,
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => Get.to(() => ShowCoupons()),
            child: Container(
              color: Colors.green.shade100,
              padding: const EdgeInsets.all(defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.loyalty, size: 25, color: primaryColor),
                  const SizedBox(width: 8),
                  Text('Apply Coupons', style: Style.smallGreentext)
                ],
              ),
            ),
          ),
          const Text(
            'Order Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Cart Total', style: Style.normalLightTextStyle),
              Text(
                '₹${c.cartTotal.value}.00',
                style: Style.normalTextStyle,
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
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () =>
                    Get.to(() => const SavedAddress(forOrder: true)),
                child:
                    Text('Proceed to payment', style: Style.normalWTextStyle)),
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
        Text('No Products in your Cart', style: Style.largeLighttextStyle)
      ],
    );
  }
}

import 'package:fit_food/Models/trainer_cart_model.dart';
import 'package:fit_food/Screens/Cart/cart_product_card.dart';
import 'package:fit_food/Screens/Cart/show_coupon.dart';
import 'package:fit_food/Screens/Profile/saved_address.dart';
import '../../Constants/export.dart';
import '../../Components/cart_controller.dart';
import '../../Models/cart_model.dart';

class Cart extends StatelessWidget {
  Cart({super.key});
  final c = Get.put(CartController());
  final controller = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: controller.isDarkTheme.value ? blackColor : whiteColor,
        foregroundColor: controller.isDarkTheme.value ? whiteColor : blackColor,
        title: const Text('Your Cart'),
      ),
      body: Obx(
        () => c.isCartLoading.value
            ? loading
            : controller.role.value == 'Trainer'
                ? FutureBuilder<TrainerCartModel>(
                    future: c.showTrainersCart(),
                    builder: (context, snapshot) => snapshot.hasData
                        ? snapshot.data!.data!.cartItems!.isEmpty
                            ? noProduct(size)
                            : Stack(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.all(defaultPadding),
                                    child: SizedBox(
                                      height: size.height * 0.58,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot
                                            .data!.data!.cartItems!.length,
                                        itemBuilder: (context, index) =>
                                            TrainersCartProductCard(
                                                snapshot: snapshot,
                                                index: index),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: buildTrainersPaymentCard(snapshot),
                                  ),
                                ],
                              )
                        : noProduct(size),
                  )
                : FutureBuilder<CartModel>(
                    future: c.showCart(),
                    builder: (context, snapshot) => snapshot.hasData
                        ? snapshot.data!.data!.cartItems!.isEmpty
                            ? noProduct(size)
                            : Stack(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.all(defaultPadding),
                                    child: SizedBox(
                                      height: size.height * 0.58,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot
                                            .data!.data!.cartItems!.length,
                                        itemBuilder: (context, index) =>
                                            CartProductCard(
                                                snapshot: snapshot,
                                                index: index),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: buildPaymentCard(snapshot),
                                  ),
                                ],
                              )
                        : noProduct(size),
                  ),
      ),
    );
  }

  Container buildPaymentCard(AsyncSnapshot<CartModel> snapshot) {
    c.cartTotal.value = snapshot.data!.data!.productMrp!.toInt();
    c.amountPayable.value = int.parse(snapshot.data!.data!.productPrice!);
    c.couponSaving.value = (snapshot.data!.data!.productMrp!.toInt() -
            int.parse(snapshot.data!.data!.productPrice!))
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
                '₹${snapshot.data!.data!.productPrice!}.00',
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

  Container buildTrainersPaymentCard(AsyncSnapshot<TrainerCartModel> snapshot) {
    c.cartTotal.value = snapshot.data!.data!.productMrp!.toInt();
    c.amountPayable.value = snapshot.data!.data!.productPrice!.toInt();
    c.couponSaving.value = (snapshot.data!.data!.productMrp!.toInt() -
            (snapshot.data!.data!.productPrice!).toInt())
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
                '₹${snapshot.data!.data!.productPrice!}.00',
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

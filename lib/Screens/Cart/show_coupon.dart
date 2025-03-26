import 'package:fit_food/Components/cart_controller.dart';
import 'package:fit_food/Models/coupon_model.dart';
import '../../Constants/export.dart';

class ShowCoupons extends StatelessWidget {
  ShowCoupons({super.key});
  final c = Get.put(GetController());
  final c1 = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coupons'),
        backgroundColor: c.isDarkTheme.value ? blackColor : whiteColor,
        foregroundColor: c.isDarkTheme.value ? whiteColor : blackColor,
      ),
      body: FutureBuilder<CouponModel>(
        future: c1.showCoupons(),
        builder: (context, snapshot) => snapshot.hasData
            ? Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Obx(
                  () => c1.isCartLoading.value
                      ? loading
                      : ListView.builder(
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (context, index) =>
                              couponCard(snapshot, index),
                        ),
                ),
              )
            : loading,
      ),
    );
  }

  Padding couponCard(AsyncSnapshot<CouponModel> snapshot, int index) {
    final item = snapshot.data!.data![index];
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: RoundedContainer(
        padding: const EdgeInsets.all(defaultPadding),
        isImage: false,
        color: whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.code!, style: Style.mediumTextStyle),
                SizedBox(
                  width: 280,
                  child: Text(
                      'Get flat ${item.discount}% off on order value above \u20B9${item.amount}',
                      style: Style.normalLightTextStyle),
                )
              ],
            ),
            TextButton(
              onPressed: () {
                c.role.value == 'Trainer'
                    ? c1.applyTrainerCoupon(code: item.code!)
                    : c1.applyCoupon(code: item.code!);
              },
              child: Text('Apply', style: Style.smallGreentext),
            )
          ],
        ),
      ),
    );
  }
}

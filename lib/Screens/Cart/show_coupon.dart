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
      backgroundColor: c.isDarkTheme.value ? blackColor : Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Available Coupons'),
        backgroundColor: c.isDarkTheme.value ? blackColor : whiteColor,
        foregroundColor: c.isDarkTheme.value ? whiteColor : blackColor,
      ),
      body: Obx(() {
        if (c1.isCartLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return FutureBuilder<CouponModel>(
          future: c1.showCoupons(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error loading coupons: ${snapshot.error}',
                  style: Style.normalLightTextStyle,
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data?.data?.isEmpty == true) {
              return const Center(
                child: Text(
                  'No coupons available at the moment',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (context, index) =>
                    _buildCouponCard(context, snapshot, index),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildCouponCard(
      BuildContext context, AsyncSnapshot<CouponModel> snapshot, int index) {
    final item = snapshot.data!.data![index];

    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.local_offer_rounded, color: primaryColor),
                    const SizedBox(width: 8),
                    Text(
                      item.code!,
                      style: Style.mediumTextStyle.copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: defaultPadding,
                horizontal: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Save ${item.discount}% on your order',
                    style: Style.mediumTextStyle,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Min. order amount: ₹${item.amount}',
                    style: Style.smallLighttextStyle,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: defaultPadding,
                left: defaultPadding,
                right: defaultPadding,
              ),
              child: Obx(() => ElevatedButton(
                    onPressed: c1.isCartLoading.value
                        ? null
                        : () async {
                            try {
                              if (c.role.value == 'Trainer') {
                                await c1.applyTrainerCoupon(code: item.code!);
                              } else {
                                await c1.applyCoupon(code: item.code!);
                              }
                              Get.back(); // Return to cart screen after successful apply
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: c1.isCartLoading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(whiteColor),
                            ),
                          )
                        : const Text('APPLY'),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

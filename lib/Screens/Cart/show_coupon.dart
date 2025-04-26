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
      backgroundColor:
          c.isDarkTheme.value ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        elevation: c.isDarkTheme.value ? 0 : 1,
        centerTitle: true,
        title: Text(
          'Available Coupons',
          style: TextStyle(
            color: c.isDarkTheme.value ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: c.isDarkTheme.value ? Colors.grey[850] : Colors.white,
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
                  style: TextStyle(
                    color:
                        c.isDarkTheme.value ? Colors.white70 : Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data?.data?.isEmpty == true) {
              return Center(
                child: Text(
                  'No coupons available at the moment',
                  style: TextStyle(
                    fontSize: 16,
                    color: c.isDarkTheme.value ? Colors.white70 : Colors.grey,
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
          color: c.isDarkTheme.value ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: c.isDarkTheme.value
                  ? Colors.black12
                  : Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
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
                color: c.isDarkTheme.value
                    ? Colors.green.shade900
                    : primaryColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_offer_rounded,
                    color: c.isDarkTheme.value ? Colors.white : primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    item.code!,
                    style: TextStyle(
                      fontSize: 16,
                      color: c.isDarkTheme.value ? Colors.white : primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
                    style: TextStyle(
                      fontSize: 16,
                      color:
                          c.isDarkTheme.value ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Min. order amount: ₹${item.amount}',
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          c.isDarkTheme.value ? Colors.white70 : Colors.black54,
                    ),
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
              child: Center(
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
                        minimumSize: const Size(double.infinity, 45),
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
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'APPLY',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

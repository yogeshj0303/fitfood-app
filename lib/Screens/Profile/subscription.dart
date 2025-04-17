import 'package:fit_food/Models/subs_model.dart';
import '../../Constants/export.dart';

class SubscriptionPlan extends StatefulWidget {
  const SubscriptionPlan({super.key});

  @override
  State<SubscriptionPlan> createState() => _SubscriptionPlanState();
}

class _SubscriptionPlanState extends State<SubscriptionPlan>
    with SingleTickerProviderStateMixin {
  final _razorpay = Razorpay();

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    ProfileUtils().purchasePlan(c.subsId.value, c.planId.value);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: ${response.code} - ${response.message}');
    Fluttertoast.showToast(
      msg: "Payment Failed: ${response.message ?? 'Unknown error occurred'}",
      toastLength: Toast.LENGTH_LONG,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: response.walletName.toString());
  }

  final c = Get.put(GetController());
  bool is2mealPlan = false;
  @override
  void initState() {
    super.initState();
    try {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    } catch (e) {
      print('Razorpay initialization error: $e');
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Plans'),
        centerTitle: true,
        backgroundColor: c.isDarkTheme.value ? blackColor : whiteColor,
        foregroundColor: c.isDarkTheme.value ? whiteColor : blackColor,
        elevation: 1,
      ),
      body: FutureBuilder<SubsModel>(
          future: ProfileUtils().getSubscriptions(),
          builder: (context, snapshot) => snapshot.hasData
              ? snapshot.data!.data!.isEmpty
                  ? Center(
                      child: Text('No Plans Available',
                          style: Style.normalTextStyle),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) =>
                          buildPlan(snapshot, index, size),
                    )
              : loading),
    );
  }

  Widget buildPlan(AsyncSnapshot<SubsModel> snapshot, int index, Size size) {
    int length = snapshot.data!.data!.length;
    var item = snapshot.data!.data![index];
    var image = item.image!;
    bool isLast = index == length - 1;
    return Padding(
      padding: isLast
          ? const EdgeInsets.all(defaultPadding * 2)
          : const EdgeInsets.fromLTRB(
              defaultPadding * 2, defaultPadding * 2, defaultPadding * 2, 0),
      child: RoundedContainer(
        color: whiteColor,
        borderColor: primaryDarkColor,
        isImage: false,
        child: Column(
          children: [
            RoundedContainer(
              height: 125,
              opacity: 0.5,
              color: blackGrey,
              networkImg: '$imgPath/$image',
              padding: const EdgeInsets.all(defaultPadding * 2),
              isImage: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item.planName} Plan',
                            style: Style.largeBoldWhiteTextStyle,
                          ),
                          Text(
                            'Validity : ${item.validity} days',
                            style: Style.mediumWTextStyle,
                          ),
                          Text(
                            item.planId == '1'
                                ? '2 Meals/days'
                                : '3 Meals/days',
                            style: Style.smallWtextStyle,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '₹${item.result!}',
                            style: Style.largeBoldWhiteTextStyle,
                          ),
                          Text(
                            'Discount : ${item.discount!.toString()}%',
                            style: Style.mediumWTextStyle,
                          ),
                          Text(
                            'Price : ₹${item.price!}',
                            style: Style.mediumWTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding * 2),
              child: Text(
                item.des!,
                style: Style.smallLighttextStyle,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: defaultPadding * 2, bottom: defaultPadding),
                  child: OutlinedButton(
                    onPressed: () {
                      try {
                        c.subsId.value = item.id!.toInt();
                        item.planId == '1'
                            ? c.planId.value = 1
                            : c.planId.value = 2;
                        var options = {
                          'key': 'rzp_test_Xnvv8oiApC5dMT',
                          'amount': int.parse(item.result!) * 100,
                          'name': 'Fitfood Meals',
                          'description': item.planName,
                          'prefill': {
                            'contact': c.phone.value,
                            'email': c.mail.value,
                          },
                          'theme': {
                            'color': '#FF6B6B',
                          }
                        };
                        print('Opening Razorpay with options: $options');
                        _razorpay.open(options);
                      } catch (e) {
                        print('Error opening Razorpay: $e');
                        Fluttertoast.showToast(
                          msg: "Failed to open payment: ${e.toString()}",
                          toastLength: Toast.LENGTH_LONG,
                        );
                      }
                    },
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: primaryColor)),
                    child: Text('Proceed to Pay',
                        style: Style.smallColortextStyle),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

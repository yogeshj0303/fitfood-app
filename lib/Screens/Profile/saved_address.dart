import 'package:fit_food/Components/address_controller.dart';
import 'package:fit_food/Components/cart_controller.dart';
import 'package:fit_food/Constants/export.dart';
import 'package:fit_food/Widgets/custom_text_field.dart';
import 'package:fit_food/Widgets/my_button.dart';

class SavedAddress extends StatefulWidget {
  final bool forOrder;
  const SavedAddress({super.key, required this.forOrder});

  @override
  State<SavedAddress> createState() => _SavedAddressState();
}

class _SavedAddressState extends State<SavedAddress> {
  final c = Get.put(GetController());
  final c1 = Get.put(AddressController());
  final c2 = Get.put(CartController());
  final locality = TextEditingController();
  final address = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final pin = TextEditingController();
  final addKey = GlobalKey<FormState>();
  final _razorpay = Razorpay();

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    c.role.value == 'Trainer'
        ? c2.trainerPlaceOrder(
            addressId: c1.defaultAddressId.value,
            payMethod: 'Online Payment with payment ID: ${response.paymentId}')
        : c2.placeOrder(
            addressId: c1.defaultAddressId.value,
            payMethod: 'Online Payment with payment ID: ${response.paymentId}');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: response.message.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: response.walletName.toString());
  }

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    c.role.value == 'Trainer' ? c1.showTrainerAddresses() : c1.showAddresses();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c.isDarkTheme.value ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: c.isDarkTheme.value ? 0 : 1,
        backgroundColor: c.isDarkTheme.value ? Colors.grey[850] : Colors.white,
        title: Text(
          widget.forOrder ? 'Select Address' : 'Saved Addresses',
          style: TextStyle(
            color: c.isDarkTheme.value ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(
        () => c1.addressList.isEmpty
            ? Center(
                child: Text(
                  widget.forOrder
                      ? 'Please add address to proceed further'
                      : 'No Address saved yet',
                  style: TextStyle(
                    color:
                        c.isDarkTheme.value ? Colors.white70 : Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(defaultPadding),
                itemCount: c1.addressList.length,
                itemBuilder: (context, index) => widget.forOrder
                    ? buildAddressCard1(index)
                    : buildAddressCard(index),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addAddressDialog(),
        backgroundColor: primaryColor,
        child: const Icon(Icons.add, color: whiteColor),
      ),
    );
  }

  Widget buildAddressCard(int index) {
    final item = c1.addressList[index];
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: Obx(
        () => Container(
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
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                c.role.value == 'Trainer' ? c.tName.value : c.name.value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: c.isDarkTheme.value ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${item.address}, ${item.city}',
                style: TextStyle(
                  color:
                      c.isDarkTheme.value ? Colors.white70 : Colors.grey[600],
                ),
              ),
              Text(
                item.locality,
                style: TextStyle(
                  color:
                      c.isDarkTheme.value ? Colors.white70 : Colors.grey[600],
                ),
              ),
              Text(
                '${item.state}, India',
                style: TextStyle(
                  color:
                      c.isDarkTheme.value ? Colors.white70 : Colors.grey[600],
                ),
              ),
              Text(
                item.pincode,
                style: TextStyle(
                  color:
                      c.isDarkTheme.value ? Colors.white70 : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                c.role.value == 'Trainer' ? c.tPhone.value : c.phone.value,
                style: TextStyle(
                  color:
                      c.isDarkTheme.value ? Colors.white70 : Colors.grey[600],
                ),
              ),
              Divider(
                color:
                    c.isDarkTheme.value ? Colors.white24 : Colors.grey.shade200,
              ),
              TextButton(
                onPressed: () => c.role.value == 'Trainer'
                    ? c1.deleteTrainerAddress(addressId: item.id)
                    : c1.deleteAddress(addressId: item.id),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddressCard1(int index) {
    final item = c1.addressList[index];
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
      child: Obx(
        () => RoundedContainer(
          onTap: () {
            c1.defaultAddressId.value = item.id.toInt();
            var options = {
              'key': 'rzp_test_Xnvv8oiApC5dMT',
              'amount': c2.amountPayable.value * 100,
              'name': 'Fitfood',
              'description': 'Healthy Food Everyday',
              'theme': {'color': '#27644D'},
              'prefill': {
                'contact': GlobalVariable.phone,
                'email': GlobalVariable.email,
              }
            };
            _razorpay.open(options);
          },
          isImage: false,
          color: whiteColor,
          padding: const EdgeInsets.all(defaultPadding * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              c.role.value == 'Trainer'
                  ? Text(c.tName.value, style: Style.normalboldTextStyle)
                  : Text(c.name.value, style: Style.normalboldTextStyle),
              const SizedBox(height: 5),
              Text('${item.address}, ${item.city}',
                  style: Style.normalLightTextStyle),
              Text(item.locality, style: Style.normalLightTextStyle),
              Text('${item.state}, India', style: Style.normalLightTextStyle),
              Text(item.pincode, style: Style.normalLightTextStyle),
              const SizedBox(height: 5),
              c.role.value == 'Trainer'
                  ? Text(c.tPhone.value, style: Style.normalLightTextStyle)
                  : Text(c.phone.value, style: Style.normalLightTextStyle),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  addAddressDialog() {
    locality.clear();
    city.clear();
    state.clear();
    pin.clear();
    address.clear();
    return Get.defaultDialog(
      title: 'Add Address',
      titleStyle: TextStyle(
        color: c.isDarkTheme.value ? Colors.white : Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: c.isDarkTheme.value ? Colors.grey[850] : Colors.white,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: addKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: address,
                  hintText: 'Address',
                  iconData: Icons.house,
                ),
                CustomTextField(
                  controller: locality,
                  hintText: 'Landmark',
                  iconData: Icons.landscape,
                ),
                CustomTextField(
                  controller: city,
                  hintText: 'City',
                  iconData: Icons.location_city,
                ),
                CustomTextField(
                  controller: state,
                  hintText: 'State',
                  iconData: Icons.real_estate_agent,
                ),
                CustomTextField(
                  controller: pin,
                  hintText: 'Pin code',
                  iconData: Icons.pin_drop,
                ),
                const SizedBox(height: 8),
                myButton(
                    onPressed: () {
                      final isValid = addKey.currentState!.validate();
                      if (isValid) {
                        Get.back();
                        c.role.value == 'Trainer'
                            ? c1.addTrainerAddress(
                                address: address.text,
                                locality: locality.text,
                                city: city.text,
                                state: state.text,
                                pincode: pin.text)
                            : c1.addAddress(
                                address: address.text,
                                locality: locality.text,
                                city: city.text,
                                state: state.text,
                                pincode: pin.text);
                      }
                    },
                    label: 'Add',
                    color: primaryColor,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

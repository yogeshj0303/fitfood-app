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
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: widget.forOrder
            ? const Text('Select Address')
            : const Text('Saved Addresses'),
      ),
      body: Obx(
        () => c1.addressList.isEmpty
            ? Center(
                child: widget.forOrder
                    ? Text('Please add address to proceed further',
                        style: Style.normalLightTextStyle)
                    : Text('No Address saved yet',
                        style: Style.normalLightTextStyle))
            : ListView.builder(
                shrinkWrap: true,
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
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
      child: Obx(
        () => RoundedContainer(
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
              const Divider(color: Colors.black12),
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
                    style: Style.normalWTextStyle)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

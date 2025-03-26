import 'package:fit_food/Components/cart_controller.dart';
import 'package:fit_food/Models/show_order_model.dart';
import '../../Constants/export.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({super.key});
  final c = Get.put(GetController());
  final c1 = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        centerTitle: true,
        backgroundColor: c.isDarkTheme.value ? blackColor : whiteColor,
        foregroundColor: c.isDarkTheme.value ? whiteColor : blackColor,
      ),
      body: FutureBuilder<ShowOrderModel>(
          future: c.role.value == 'Trainer'
              ? c1.showTrainersOrders()
              : c1.showOrders(),
          builder: (context, snapshot) => snapshot.hasData
              ? snapshot.data!.orders!.isEmpty
                  ? noOrder()
                  : Padding(
                      padding: const EdgeInsets.all(defaultPadding * 1.5),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.orders!.length,
                        itemBuilder: (context, index) =>
                            OrdersCard(snapshot: snapshot, index: index, c: c),
                      ),
                    )
              : loading),
    );
  }

  Align noOrder() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.restaurant, size: 40),
          Text('No Orders Yet', style: Style.largeLighttextStyle)
        ],
      ),
    );
  }
}

class OrdersCard extends StatelessWidget {
  final AsyncSnapshot<ShowOrderModel> snapshot;
  final int index;
  final GetController c;
  const OrdersCard(
      {super.key,
      required this.snapshot,
      required this.index,
      required this.c});

  @override
  Widget build(BuildContext context) {
    final address = snapshot.data!.orders![index].address!;
    final orderId = snapshot.data!.orders![index].orderid;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding * 1.5),
      child: RoundedContainer(
        borderColor: Colors.black12,
        padding: const EdgeInsets.all(defaultPadding * 1.5),
        color: whiteColor,
        isImage: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID : $orderId!', style: Style.largeTextStyle),
            Text(
                snapshot
                    .data!.orders![index].orderdetails![0].details!.createdAt!
                    .split('T')
                    .first,
                style: Style.normalTextStyle),
            Text('Delivery Address : ', style: Style.normalColorTextStyle),
            Text(
                '${address.address1!},\n${address.locality!},\n${address.city!}, ${address.state},\n${address.pinCode}',
                style: Style.normalTextStyle),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.orders![index].orderdetails!.length,
              itemBuilder: (context, ind) =>
                  ordersItemCard(snapshot, ind, size),
            )
          ],
        ),
      ),
    );
  }

  ordersItemCard(AsyncSnapshot<ShowOrderModel> snapshot, int ind, Size size) {
    final item = snapshot.data!.orders![index].orderdetails![ind].details!;
    return Padding(
      padding: const EdgeInsets.only(top: defaultPadding),
      child: RoundedContainer(
        padding: const EdgeInsets.all(defaultPadding),
        isImage: false,
        color: whiteColor,
        borderColor: Colors.black12,
        child: Row(
          children: [
            RoundedContainer(
              height: 150,
              borderColor: Colors.black12,
              width: size.width * 0.3,
              isImage: true,
              networkImg: '$imgPath/${item.image}',
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                item.mealId == '1'
                    ? MealType(
                        color: Colors.yellow.shade600,
                        type: 'Egge',
                      )
                    : item.mealId == '2'
                        ? const MealType(
                            color: Colors.green,
                            type: 'Veg',
                          )
                        : item.mealId == '3'
                            ? const MealType(
                                color: Colors.brown,
                                type: 'Vegan',
                              )
                            : const MealType(
                                color: Colors.red,
                                type: 'Non',
                              ),
                const SizedBox(height: 8),
                SizedBox(
                  width: size.width / 2,
                  child: Text(
                    item.subcategory!.toUpperCase(),
                    style: Style.normalTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                Text('₹${item.price}', style: Style.normalColorTextStyle),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('Quantity :', style: Style.smalltextStyle),
                    const SizedBox(width: 8),
                    Text(
                        snapshot
                            .data!.orders![index].orderdetails![ind].quantity
                            .toString(),
                        style: Style.smalltextStyle),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                    'Status : ${snapshot.data!.orders![index].activeStatus.toString()}',
                    style: Style.normalColorTextStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

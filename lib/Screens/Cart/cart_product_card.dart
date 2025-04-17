import 'package:fit_food/Components/cart_controller.dart';
import 'package:fit_food/Models/trainer_cart_model.dart';
import 'package:fit_food/Widgets/my_button.dart';
import '../../Constants/export.dart';
import '../../Models/cart_model.dart';
import '../../Widgets/my_container.dart';

class CartProductCard extends StatelessWidget {
  final CartModel model;
  final int index;

  CartProductCard({super.key, required this.model, required this.index});
  final c = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    final item = model.data!.cartItems![index];
    final image = model.data!.cartItems![index].productsDetails!.image!;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: RoundedContainer(
        padding: const EdgeInsets.all(defaultPadding),
        isImage: false,
        color: whiteColor,
        child: Row(
          children: [
            RoundedContainer(
              height: 150,
              width: size.width * 0.3,
              isImage: true,
              networkImg: '$imgPath/$image',
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width * 0.47,
                          child: Text(
                            item.productsDetails!.subcategory!.toUpperCase(),
                            style: Style.normalTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            Text('₹', style: Style.normalTextStyle),
                            Text(
                              int.parse(item.price!).toString(),
                              style: Style.normalTextStyle,
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                    item.productsDetails!.mealId == '1'
                        ? MealType(
                            color: Colors.yellow.shade600,
                            type: 'Egge',
                          )
                        : item.productsDetails!.mealId == '2'
                            ? const MealType(
                                color: Colors.green,
                                type: 'Veg',
                              )
                            : item.productsDetails!.mealId == '3'
                                ? const MealType(
                                    color: Colors.brown,
                                    type: 'Vegan',
                                  )
                                : const MealType(
                                    color: Colors.red,
                                    type: 'Non',
                                  )
                  ],
                ),
                const SizedBox(height: 2),
                SizedBox(
                  width: size.width / 2 + 16,
                  child: Text(
                    item.productsDetails!.description!,
                    style: Style.smallLighttextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    RoundedContainer(
                      onTap: () => showQuantityUpdateDialog(model, index),
                      isImage: false,
                      color: bgColor,
                      padding: const EdgeInsets.symmetric(
                        vertical: defaultPadding * 0.5,
                        horizontal: defaultPadding * 0.5,
                      ),
                      child: Row(
                        children: [
                          Text('Quantity : ${item.quantity}',
                              style: Style.smallLighttextStyle),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => c.deleteItem(cartId: item.id!.toInt()),
                      icon: const Icon(Icons.delete),
                      label: const Text('Remove'),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  showQuantityUpdateDialog(CartModel model, int index) {
    final item = model.data!.cartItems![index];
    c.qty.value = 1;
    return Get.defaultDialog(
      title: 'Select Quantity',
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    c.qty.value > 1 ? c.qty.value-- : null;
                  },
                  child: Text('-', style: Style.largeTextStyle)),
              MyContainer(
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding * 3, vertical: defaultPadding),
                child: Obx(() => Text(c.qty.value.toString())),
              ),
              TextButton(
                  onPressed: () {
                    c.qty.value < 11 ? c.qty.value++ : null;
                  },
                  child: Text('+', style: Style.largeTextStyle)),
            ],
          ),
          const SizedBox(height: 16),
          myButton(
              onPressed: () =>
                  c.updateQuantity(qty: c.qty.value, cartId: item.id!.toInt()),
              label: 'UPDATE',
              color: primaryColor,
              style: Style.smallWtextStyle)
        ],
      ),
    );
  }
}

class TrainersCartProductCard extends StatelessWidget {
  final TrainerCartModel snapshot;
  final int index;
  TrainersCartProductCard(
      {super.key, required this.snapshot, required this.index});
  final c = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    final item = snapshot.data!.cartItems![index];
    final image = snapshot.data!.cartItems![index].productsDetails!.image!;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: RoundedContainer(
        padding: const EdgeInsets.all(defaultPadding),
        isImage: false,
        color: whiteColor,
        child: Row(
          children: [
            RoundedContainer(
              height: 150,
              width: size.width * 0.3,
              isImage: true,
              networkImg: '$imgPath/$image',
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width * 0.47,
                          child: Text(
                            item.productsDetails!.subcategory!.toUpperCase(),
                            style: Style.normalTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            Text('₹', style: Style.normalTextStyle),
                            Text(
                              int.parse(item.price!).toString(),
                              style: Style.normalTextStyle,
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                    item.productsDetails!.mealId == '1'
                        ? MealType(
                            color: Colors.yellow.shade600,
                            type: 'Egge',
                          )
                        : item.productsDetails!.mealId == '2'
                            ? const MealType(
                                color: Colors.green,
                                type: 'Veg',
                              )
                            : item.productsDetails!.mealId == '3'
                                ? const MealType(
                                    color: Colors.brown,
                                    type: 'Vegan',
                                  )
                                : const MealType(
                                    color: Colors.red,
                                    type: 'Non',
                                  )
                  ],
                ),
                const SizedBox(height: 2),
                SizedBox(
                  width: size.width / 2 + 16,
                  child: Text(
                    item.productsDetails!.description!,
                    style: Style.smallLighttextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    RoundedContainer(
                      onTap: () => showQuantityUpdateDialog(snapshot, index),
                      isImage: false,
                      color: bgColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultPadding * 0.5,
                          horizontal: defaultPadding),
                      child: Row(
                        children: [
                          Text('Quantity : ${item.quantity}',
                              style: Style.smallLighttextStyle),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    TextButton.icon(
                      onPressed: () =>
                          c.deleteTrainersItem(cartId: item.id!.toInt()),
                      icon: const Icon(Icons.delete),
                      label: const Text('Remove'),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  showQuantityUpdateDialog(TrainerCartModel snapshot, int index) {
    final item = snapshot.data!.cartItems![index];
    c.qty.value = 1;
    return Get.defaultDialog(
      title: 'Select Quantity',
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    c.qty.value > 1 ? c.qty.value-- : null;
                  },
                  child: Text('-', style: Style.largeTextStyle)),
              MyContainer(
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding * 3, vertical: defaultPadding),
                child: Obx(() => Text(c.qty.value.toString())),
              ),
              TextButton(
                  onPressed: () {
                    c.qty.value < 11 ? c.qty.value++ : null;
                  },
                  child: Text('+', style: Style.largeTextStyle)),
            ],
          ),
          const SizedBox(height: 16),
          myButton(
              onPressed: () => c.updateTrainerCartQuantity(
                  qty: c.qty.value, cartId: item.id!.toInt()),
              label: 'UPDATE',
              color: primaryColor,
              style: Style.smallWtextStyle)
        ],
      ),
    );
  }
}

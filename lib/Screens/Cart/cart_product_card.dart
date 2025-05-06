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
    c.qty.value = int.parse(item.quantity.toString());
    return Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Update Quantity',
                style: Style.largeTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (c.qty.value > 1) {
                        c.qty.value--;
                      }
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: c.qty.value > 1 ? primaryColor.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.remove,
                        color: c.qty.value > 1 ? primaryColor : Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(() => Text(
                      c.qty.value.toString(),
                      style: Style.largeTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                  IconButton(
                    onPressed: () {
                      if (c.qty.value < 11) {
                        c.qty.value++;
                      }
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: c.qty.value < 11 ? primaryColor.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: c.qty.value < 11 ? primaryColor : Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(color: primaryColor),
                      ),
                      child: Text(
                        'Cancel',
                        style: Style.normalTextStyle.copyWith(
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (c.qty.value != int.parse(item.quantity.toString())) {
                          c.updateQuantity(qty: c.qty.value, cartId: item.id!.toInt());
                        } else {
                          Get.back();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Update',
                        style: Style.normalTextStyle.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
    c.qty.value = int.parse(item.quantity.toString());
    return Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Update Quantity',
                style: Style.largeTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (c.qty.value > 1) {
                        c.qty.value--;
                      }
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: c.qty.value > 1 ? primaryColor.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.remove,
                        color: c.qty.value > 1 ? primaryColor : Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(() => Text(
                      c.qty.value.toString(),
                      style: Style.largeTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                  IconButton(
                    onPressed: () {
                      if (c.qty.value < 11) {
                        c.qty.value++;
                      }
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: c.qty.value < 11 ? primaryColor.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: c.qty.value < 11 ? primaryColor : Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(color: primaryColor),
                      ),
                      child: Text(
                        'Cancel',
                        style: Style.normalTextStyle.copyWith(
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (c.qty.value != int.parse(item.quantity.toString())) {
                          c.updateTrainerCartQuantity(
                              qty: c.qty.value, cartId: item.id!.toInt());
                        } else {
                          Get.back();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Update',
                        style: Style.normalTextStyle.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

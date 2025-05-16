// ignore_for_file: deprecated_member_use
import 'package:fit_food/Components/cart_controller.dart';
import 'package:fit_food/Screens/Cart/cart_screen.dart';
import '../../../Constants/export.dart' hide Data; // Hide Data from export.dart
import '../../../Models/foodsubcat_model.dart'; // This will provide the Data class we need

class FoodCatDetails extends StatefulWidget {
  final AsyncSnapshot<FoodSubCategoryModel> snapshot;
  final int ind;

  const FoodCatDetails({
    super.key,
    required this.snapshot,
    required this.ind,
  });

  @override
  State<FoodCatDetails> createState() => _FoodCatDetailsState();
}

class _FoodCatDetailsState extends State<FoodCatDetails> {
  final c = Get.put(CartController());
  final c1 = Get.put(GetController());
  late Future<FoodSubCategoryModel> similarItems;

  @override
  void initState() {
    super.initState();
    // Fetch similar items using the same category ID
    final categoryId = widget.snapshot.data!.data![widget.ind].categoryId;
    similarItems = HomeUtils().getFoodSubCategries(int.parse(categoryId!));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final item = widget.snapshot.data!.data![widget.ind];
    final image = item.image!;

    return Obx(() => Scaffold(
          backgroundColor:
              c1.isDarkTheme.value ? Colors.grey[900] : Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Obx(
                () => c.isLoading.value
                    ? loading
                    : Column(
                        children: [
                          Stack(
                            children: [
                              InteractiveViewer(
                                minScale: 0.5,
                                maxScale: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          '$imgPath/$image'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: size.height / 3,
                                  width: size.width,
                                  child: CachedNetworkImage(
                                    imageUrl: '$imgPath/$image',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 16,
                                right: 16,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Stack(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          // Navigate to MainScreen and switch to cart tab
                                          Get.until((route) =>
                                              Get.currentRoute == '/MainScreen');
                                          Get.find<GetController>()
                                              .currIndex
                                              .value = 3; // Cart is at index 3
                                        },
                                        icon: const Icon(
                                          Icons.shopping_cart,
                                          color: primaryColor,
                                          size: 28,
                                        ),
                                      ),
                                      Obx(() {
                                        if (c.qty.value > 0) {
                                          return Positioned(
                                            right: 0,
                                            top: 0,
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2,
                                                ),
                                              ),
                                              constraints: const BoxConstraints(
                                                minWidth: 16,
                                                minHeight: 16,
                                              ),
                                              child: Text(
                                                c.qty.value.toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          );
                                        }
                                        return const SizedBox.shrink();
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(defaultPadding * 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.subcategory!,
                                          style: Style.largeTextStyle.copyWith(
                                            color: c1.isDarkTheme.value
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                        ),
                                        Text(
                                          '₹${item.price!}',
                                          style: Style.mediumTextStyle.copyWith(
                                            color: c1.isDarkTheme.value
                                                ? Colors.white70
                                                : Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                    item.mealId! == '1'
                                        ? MealType(
                                            color: Colors.yellow.shade600,
                                            type: 'Egge',
                                          )
                                        : item.mealId! == '2'
                                            ? const MealType(
                                                color: Colors.green,
                                                type: 'Veg',
                                              )
                                            : item.mealId! == '3'
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
                                const SizedBox(height: defaultMargin),
                                Text(
                                  'Description : ',
                                  style: Style.normalTextStyle.copyWith(
                                    color: c1.isDarkTheme.value
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: defaultMargin),
                                Text(
                                  item.description!,
                                  style: Style.normalLightTextStyle.copyWith(
                                    color: c1.isDarkTheme.value
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: defaultMargin * 2),
                                Text(
                                  'You may also like:',
                                  style: Style.normalTextStyle.copyWith(
                                    color: c1.isDarkTheme.value
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: defaultMargin),
                                SizedBox(
                                  height: 280,
                                  child: FutureBuilder<FoodSubCategoryModel>(
                                    future: similarItems,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }

                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(
                                            'Error loading similar items',
                                            style: Style.normalLightTextStyle,
                                          ),
                                        );
                                      }

                                      if (!snapshot.hasData ||
                                          snapshot.data!.data!.isEmpty) {
                                        return Center(
                                          child: Text(
                                            'No similar items found',
                                            style: Style.normalLightTextStyle,
                                          ),
                                        );
                                      }

                                      return ListView.builder(
                                        clipBehavior: Clip.none,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        physics: const BouncingScrollPhysics(),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: defaultPadding,
                                        ),
                                        itemCount: snapshot.data!.data!.length,
                                        itemBuilder: (context, index) {
                                          final similarItem =
                                              snapshot.data!.data![index];
                                          // Skip current item
                                          if (similarItem.id == item.id) {
                                            return const SizedBox.shrink();
                                          }
                                          return buildFoodCard(
                                              size, similarItem);
                                        },
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                    height:
                                        defaultMargin * 2), // Bottom padding
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          bottomSheet: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: c1.isDarkTheme.value ? Colors.grey[850] : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Quantity controls
                Container(
                  decoration: BoxDecoration(
                    color: c1.isDarkTheme.value ? Colors.grey[800] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (c.qty.value > 1) {
                            c.qty.value--;
                          }
                        },
                        icon: Icon(
                          Icons.remove_circle_outline,
                          color: c1.isDarkTheme.value ? Colors.white70 : Colors.black87,
                          size: 24,
                        ),
                      ),
                      Obx(() => Text(
                            c.qty.value.toString(),
                            style: Style.mediumTextStyle.copyWith(
                              color: c1.isDarkTheme.value ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      IconButton(
                        onPressed: () {
                          if (c.qty.value < 11) {
                            c.qty.value++;
                          }
                        },
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: c1.isDarkTheme.value ? Colors.white70 : Colors.black87,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                // Add to cart button
                ElevatedButton(
                  onPressed: () {
                    c1.role.value == 'Trainer'
                        ? c.addToTrainerCart(
                            widget.snapshot.data!.data![widget.ind].id!.toInt())
                        : c.addToCart(
                            widget.snapshot.data!.data![widget.ind].id!.toInt());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 2,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.shopping_cart_outlined, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Add to Cart',
                        style: Style.mediumTextStyle.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildFoodCard(Size size, Data item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: GestureDetector(
        onTap: () async {
          try {
            // Fetch full category data for this item
            final fullData = await HomeUtils()
                .getFoodSubCategries(int.parse(item.categoryId!));

            // Find the correct index of the item in the fetched data
            final index =
                fullData.data!.indexWhere((element) => element.id == item.id);

            if (index != -1) {
              // Navigate to CatDetails with the fetched data and found index
              Get.off(() => CatDetails(
                    snapshot:
                        AsyncSnapshot.withData(ConnectionState.done, fullData),
                    ind: index,
                  ));
            } else {
              throw Exception('Item not found in category data');
            }
          } catch (e) {
            print('Error navigating to details: $e');
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Unable to load details')));
          }
        },
        child: Container(
          clipBehavior: Clip.none,
          margin: const EdgeInsets.only(right: defaultPadding),
          width: size.width * 0.6,
          child: Card(
            clipBehavior: Clip.antiAlias,
            color: c1.isDarkTheme.value ? Colors.grey[850] : whiteColor,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: '$imgPath/${item.image}',
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: _buildMealTypeBadge(item.mealId!),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.subcategory!,
                        style: Style.normalTextStyle.copyWith(
                          color: c1.isDarkTheme.value
                              ? Colors.white
                              : Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹${item.price}',
                        style: Style.smallColortextStyle,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                starIcon,
                                height: 16,
                                color: primaryColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '4.7',
                                style: Style.smallLighttextStyle.copyWith(
                                  color: c1.isDarkTheme.value
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'India',
                            style: Style.smallLighttextStyle.copyWith(
                              color: c1.isDarkTheme.value
                                  ? Colors.white70
                                  : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Add this helper method for meal type badge
  Widget _buildMealTypeBadge(String mealId) {
    switch (mealId) {
      case '1':
        return MealType(color: Colors.yellow.shade600, type: 'Egg');
      case '2':
        return const MealType(color: Colors.green, type: 'Veg');
      case '3':
        return const MealType(color: Colors.brown, type: 'Vegan');
      default:
        return const MealType(color: Colors.red, type: 'Non');
    }
  }
}

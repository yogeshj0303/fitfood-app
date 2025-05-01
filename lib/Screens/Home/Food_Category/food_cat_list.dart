import 'package:fit_food/Models/foodsubcat_model.dart' as subcat;
import '../../../Constants/export.dart'
    hide Data; // Hides the conflicting 'Data' from this import
import 'package:fit_food/Models/foodsubcat_model.dart'; // Ensure this file contains the definition of FoodSubCategoryModelData

// If FoodSubCategoryModelData is not defined, define it here or ensure it exists in the imported file.
class FoodSubCategoryModelData {
  final String? subcategory;
  final String? price;
  final String? mealId;
  final String? image;
  final String? description;
  final double? rating;

  FoodSubCategoryModelData({
    this.subcategory,
    this.price,
    this.mealId,
    this.image,
    this.description,
    this.rating,
  });
}

class FoodCatLists extends StatefulWidget {
  final String image;
  final String name;
  final int subCatId;

  const FoodCatLists({
    super.key,
    required this.image,
    required this.name,
    required this.subCatId,
  });

  @override
  State<FoodCatLists> createState() => _FoodCatListsState();
}

class _FoodCatListsState extends State<FoodCatLists> {
  // Add GetController instance
  final c = Get.find<GetController>();
  final ScrollController _scrollController = ScrollController();
  final RxString _sortBy = 'Default'.obs;
  final RxBool _isVeg = false.obs;
  final RxBool _isNonVeg = false.obs;
  final RxBool _isEgg = false.obs;
  final RxBool _isVegan = false.obs;
  final RxString _priceRange = 'All'.obs; // Add this line to define _priceRange

  // Add this variable to cache the data
  late Future<FoodSubCategoryModel> _foodData;

  @override
  void initState() {
    super.initState();
    _foodData = HomeUtils().getFoodSubCategries(widget.subCatId);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(() => Scaffold(
          backgroundColor:
              c.isDarkTheme.value ? Colors.grey[900] : Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          defaultPadding, 0, defaultPadding, defaultPadding),
                      child: FutureBuilder<FoodSubCategoryModel>(
                        future: _foodData,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return _buildErrorWidget();
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return loading;
                          }

                          if (!snapshot.hasData ||
                              snapshot.data!.data!.isEmpty) {
                            return _buildNoDataWidget(widget.name);
                          }

                          // Get sorted data
                          final sortedData =
                              _getSortedData(snapshot.data!.data!);

                          return Scrollbar(
                            controller: _scrollController,
                            thumbVisibility: true,
                            child: Column(
                              children: [
                                // Update BannerWidget if needed
                                BannerWidget(
                                  name: widget.name,
                                  iImage: widget.image,
                                  opacity: c.isDarkTheme.value ? 0.6 : 0.4,
                                ),
                                const SizedBox(height: defaultPadding),
                                // Update Sort and Filter Bar
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    color: c.isDarkTheme.value
                                        ? Colors.grey[850]
                                        : Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: defaultPadding,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () => _showSortBottomSheet(),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: c.isDarkTheme.value
                                                        ? Colors.grey[700]!
                                                        : Colors.grey[300]!),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.sort,
                                                      size: 20,
                                                      color: c.isDarkTheme.value
                                                          ? Colors.white
                                                          : Colors.black87),
                                                  const SizedBox(width: 8),
                                                  Flexible(
                                                    child: Obx(() => Text(
                                                          'Sort: ${_sortBy.value}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: Style
                                                              .smalltextStyle
                                                              .copyWith(
                                                                  color: c.isDarkTheme
                                                                          .value
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black87),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () =>
                                                _showFilterBottomSheet(),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: c.isDarkTheme.value
                                                        ? Colors.grey[700]!
                                                        : Colors.grey[300]!),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(Icons.filter_list,
                                                      size: 20),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    'Filter',
                                                    style: Style.smalltextStyle,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: defaultPadding),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: sortedData.length,
                                  itemBuilder: (context, index) {
                                    final modifiedSnapshot = AsyncSnapshot<
                                            FoodSubCategoryModel>.withData(
                                        ConnectionState.done,
                                        FoodSubCategoryModel(
                                            data: [sortedData[index]]));
                                    return buildFoodsCard(
                                        size, modifiedSnapshot, 0);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _showSortBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: c.isDarkTheme.value ? Colors.grey[850] : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sort By',
                style: Style.mediumTextStyle.copyWith(
                    color:
                        c.isDarkTheme.value ? Colors.white : Colors.black87)),
            const SizedBox(height: 16),
            ListTile(
              onTap: () {
                _sortBy.value = 'Price: Low to High';
                Get.back();
                setState(() {});
              },
              title: Text('Price: Low to High',
                  style: Style.smalltextStyle.copyWith(
                      color: c.isDarkTheme.value
                          ? Colors.white70
                          : Colors.black87)),
            ),
            ListTile(
              onTap: () {
                _sortBy.value = 'Price: High to Low';
                Get.back();
                setState(() {}); // Add this to trigger rebuild
              },
              title: Text('Price: High to Low',
                  style: Style.smalltextStyle.copyWith(
                      color: c.isDarkTheme.value
                          ? Colors.white70
                          : Colors.black87)),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: c.isDarkTheme.value ? Colors.grey[850] : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Filter',
                style: Style.mediumTextStyle.copyWith(
                    color:
                        c.isDarkTheme.value ? Colors.white : Colors.black87)),
            const SizedBox(height: 16),
            Text('Meal Type',
                style: Style.smalltextStyle.copyWith(
                    color:
                        c.isDarkTheme.value ? Colors.white70 : Colors.black87)),
            Obx(() => Wrap(
                  spacing: 8,
                  children: [
                    FilterChip(
                      label: Text('Veg',
                          style: TextStyle(
                              color: c.isDarkTheme.value
                                  ? Colors.white
                                  : Colors.black87)),
                      selected: _isVeg.value,
                      onSelected: (val) => _isVeg.value = val,
                      backgroundColor: c.isDarkTheme.value
                          ? Colors.grey[800]
                          : Colors.grey[200],
                    ),
                    FilterChip(
                      label: Text('Non-Veg',
                          style: TextStyle(
                              color: c.isDarkTheme.value
                                  ? Colors.white
                                  : Colors.black87)),
                      selected: _isNonVeg.value,
                      onSelected: (val) => _isNonVeg.value = val,
                      backgroundColor: c.isDarkTheme.value
                          ? Colors.grey[800]
                          : Colors.grey[200],
                    ),
                    FilterChip(
                      label: Text('Egg',
                          style: TextStyle(
                              color: c.isDarkTheme.value
                                  ? Colors.white
                                  : Colors.black87)),
                      selected: _isEgg.value,
                      onSelected: (val) => _isEgg.value = val,
                      backgroundColor: c.isDarkTheme.value
                          ? Colors.grey[800]
                          : Colors.grey[200],
                    ),
                    FilterChip(
                      label: Text('Vegan',
                          style: TextStyle(
                              color: c.isDarkTheme.value
                                  ? Colors.white
                                  : Colors.black87)),
                      selected: _isVegan.value,
                      onSelected: (val) => _isVegan.value = val,
                      backgroundColor: c.isDarkTheme.value
                          ? Colors.grey[800]
                          : Colors.grey[200],
                    ),
                  ],
                )),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    _isVeg.value = false;
                    _isNonVeg.value = false;
                    _isEgg.value = false;
                    _isVegan.value = false;
                  },
                  child: Text('Clear All'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                    setState(() {});
                  },
                  child: Text('Apply'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Add this method to handle sorting
  List<subcat.Data> _getSortedData(List<subcat.Data> items) {
    // First, apply filters
    var filteredItems = items.where((item) {
      // Filter by meal type
      bool mealTypeMatch = true;
      if (_isVeg.value && item.mealId == '2' ||
          _isNonVeg.value && item.mealId == '4' ||
          _isEgg.value && item.mealId == '1' ||
          _isVegan.value && item.mealId == '3') {
        mealTypeMatch = true;
      } else if (_isVeg.value ||
          _isNonVeg.value ||
          _isEgg.value ||
          _isVegan.value) {
        mealTypeMatch = false;
      }

      // Filter by price range
      bool priceMatch = true;
      double price = double.tryParse(item.price ?? '0') ?? 0;

      switch (_priceRange.value) {
        case 'Under ₹300':
          priceMatch = price < 300;
          break;
        case '₹300 - ₹600':
          priceMatch = price >= 300 && price <= 600;
          break;
        case 'Above ₹600':
          priceMatch = price > 600;
          break;
        default: // 'All'
          priceMatch = true;
      }

      return mealTypeMatch && priceMatch;
    }).toList();

    // Then apply sorting
    switch (_sortBy.value) {
      case 'Price: Low to High':
        filteredItems.sort((a, b) {
          final priceA = double.tryParse(a.price ?? '0') ?? 0;
          final priceB = double.tryParse(b.price ?? '0') ?? 0;
          return priceA.compareTo(priceB);
        });
        break;
      case 'Price: High to Low':
        filteredItems.sort((a, b) {
          final priceA = double.tryParse(a.price ?? '0') ?? 0;
          final priceB = double.tryParse(b.price ?? '0') ?? 0;
          return priceB.compareTo(priceA);
        });
        break;
      case 'Rating':
        filteredItems.sort((a, b) {
          final ratingA = a.rating ?? 0;
          final ratingB = b.rating ?? 0;
          return ratingB.compareTo(ratingA);
        });
        break;
    }

    return filteredItems;
  }
}

Widget _buildNoDataWidget(String categoryName) {
  return SizedBox(
    height: Get.height - 100,
    child: Container(
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/no_item.jpg',
                height: 180,
                width: 180,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 32),
              Text(
                'No Items Found',
                style: Style.largeTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'No items available in\n$categoryName category',
                style: Style.smallLighttextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Go Back',
                        style: Style.mediumTextStyle.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildErrorWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 60,
        ),
        const SizedBox(height: 16),
        Text(
          'Something went wrong',
          style: Style.mediumTextStyle,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => Get.back(),
          child: const Text('Go Back'),
        ),
      ],
    ),
  );
}

Widget buildFoodsCard(
    Size size, AsyncSnapshot<FoodSubCategoryModel> snapshot, int index) {
  final c = Get.find<GetController>();
  var item = snapshot.data!.data![index];

  return Padding(
    padding: const EdgeInsets.only(bottom: defaultPadding),
    child: GestureDetector(
      onTap: () => Get.to(() => FoodCatDetails(snapshot: snapshot, ind: index)),
      child: RoundedContainer(
        padding: const EdgeInsets.symmetric(vertical: defaultPadding),
        height: size.height / 5,
        width: size.width,
        borderColor: c.isDarkTheme.value ? Colors.grey[700]! : Colors.black12,
        isImage: false,
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundedContainer(
                height: size.height / 6,
                width: size.width / 3,
                networkImg: '$imgPath/${item.image}',
                isImage: true,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * 0.42,
                              child: Text(
                                item.subcategory!,
                                style: Style.mediumTextStyle.copyWith(
                                    color: c.isDarkTheme.value
                                        ? Colors.white
                                        : Colors.black87),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '₹ ${item.price}',
                              style: Style.normalTextStyle,
                            ),
                          ],
                        ),
                        const SizedBox(width: 5),
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
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SvgPicture.asset(
                          starIcon,
                          height: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '5.0 (100+) ',
                          style: Style.normalTextStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 30,
                      width: size.width / 2 - 12,
                      child: Text(
                        item.description!,
                        style: Style.smallLighttextStyle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
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

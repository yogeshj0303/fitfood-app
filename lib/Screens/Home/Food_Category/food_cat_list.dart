import 'package:fit_food/Models/foodsubcat_model.dart';
import '../../../Constants/export.dart';

class FoodCatLists extends StatelessWidget {
  final String image;
  final String name;
  final int subCatId;
  const FoodCatLists(
      {super.key,
      required this.image,
      required this.name,
      required this.subCatId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                defaultPadding, 0, defaultPadding, defaultPadding),
            child: FutureBuilder<FoodSubCategoryModel>(
              future: HomeUtils().getFoodSubCategries(subCatId),
              builder: (context, snapshot) => snapshot.hasData
                  ? snapshot.data!.data!.isEmpty
                      ? Center(
                          child: Text('No Data Found',
                              style: Style.largeTextStyle))
                      : Scrollbar(
                          thumbVisibility: true,
                          child: Column(
                            children: [
                              BannerWidget(
                                name: name,
                                iImage: image,
                                opacity: 0.4,
                              ),
                              const SizedBox(height: defaultPadding),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.data!.length,
                                itemBuilder: (context, index) =>
                                    buildFoodsCard(size, snapshot, index),
                              ),
                            ],
                          ),
                        )
                  : loading,
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildFoodsCard(
    Size size, AsyncSnapshot<FoodSubCategoryModel> snapshot, int index) {
  var item = snapshot.data!.data![index];
  return Padding(
    padding: const EdgeInsets.only(bottom: defaultPadding),
    child: GestureDetector(
      onTap: () => Get.to(
        () => FoodCatDetails(
          snapshot: snapshot,
          ind: index,
        ),
      ),
      child: RoundedContainer(
        padding: const EdgeInsets.symmetric(vertical: defaultPadding),
        height: size.height / 5,
        width: size.width,
        borderColor: Colors.black12,
        isImage: false,
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            children: [
              RoundedContainer(
                height: size.height / 6,
                width: size.width / 3,
                networkImg: '$imgPath/${item.image}',
                isImage: true,
              ),
              const SizedBox(width: 12),
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
                            width: size.width * 0.42,
                            child: Text(
                              item.subcategory!,
                              style: Style.mediumTextStyle,
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
                    height: 50,
                    width: size.width / 2 - 12,
                    child: Text(
                      item.description!,
                      style: Style.smallLighttextStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// ignore_for_file: deprecated_member_use
import 'package:fit_food/Components/cart_controller.dart';

import '../../../Constants/export.dart';
import '../../../Models/foodsubcat_model.dart';

class CatDetails extends StatelessWidget {
  final AsyncSnapshot<FoodSubCategoryModel> snapshot;
  final int ind;
  CatDetails({
    super.key,
    required this.snapshot,
    required this.ind,
  });
  final c = Get.put(CartController());
  final c1 = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    final count = snapshot.data!.data!.length;
    final size = MediaQuery.of(context).size;
    final item = snapshot.data!.data![ind];
    final image = item.image!;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              InteractiveViewer(
                minScale: 0.5,
                maxScale: 2,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider('$imgPath/$image'),
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
              Padding(
                padding: const EdgeInsets.all(defaultPadding * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.subcategory!,
                              style: Style.largeTextStyle,
                            ),
                            Text(
                              '₹${item.price!}',
                              style: Style.mediumTextStyle,
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
                                      ),
                      ],
                    ),
                    const SizedBox(height: defaultMargin),
                    Text(
                      'Description : ',
                      style: Style.normalTextStyle,
                    ),
                    const SizedBox(height: defaultMargin),
                    Text(item.description!, style: Style.smallLighttextStyle),
                    const SizedBox(height: defaultMargin),
                    Text(
                      'You may also like :',
                      style: Style.normalTextStyle,
                    ),
                    const SizedBox(height: defaultMargin),
                    SizedBox(
                      height: size.height / 4,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: count,
                        itemBuilder: (context, index) => index == ind
                            ? Container()
                            : buildMayLikeCard(size, snapshot, index),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: InkWell(
        onTap: () {
          c1.role.value == 'Trainer'
              ? c.addToTrainerCart(snapshot.data!.data![ind].id!.toInt())
              : c.addToCart(snapshot.data!.data![ind].id!.toInt());
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_mall, color: primaryColor),
              const SizedBox(width: 12),
              Text('Add to cart', style: Style.mediumTextStyle),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMayLikeCard(
      Size size, AsyncSnapshot<FoodSubCategoryModel> snapshot, int index) {
    final item = snapshot.data!.data![index];
    final image = item.image!;
    return InkWell(
      onTap: () =>
          Get.off(() => FoodCatDetails(snapshot: snapshot, ind: index)),
      child: Card(
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(defaultCardRadius),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: defaultPadding * 2),
          child: RoundedContainer(
            height: size.height / 2,
            width: size.width / 2 - (defaultPadding * 4),
            padding: const EdgeInsets.all(defaultPadding),
            isImage: false,
            borderColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: item.mealId! == '1'
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
                                ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: greyColor,
                  backgroundImage: CachedNetworkImageProvider(
                    '$imgPath/$image',
                  ),
                ),
                const Spacer(),
                Text(
                  item.subcategory!,
                  style: Style.smalltextStyle,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text('₹${item.price!}',
                    style: Style.smallLighttextStyle,
                    textAlign: TextAlign.center),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      starIcon,
                      height: 20,
                      width: 25,
                      color: primaryColor,
                    ),
                    const Spacer(flex: 1),
                    Text('4.7', style: Style.smallLighttextStyle),
                    const Spacer(flex: 5),
                    Text('India', style: Style.smallLighttextStyle),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

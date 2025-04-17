// ignore_for_file: deprecated_member_use
import 'package:fit_food/Controllers/home_controller.dart';
import 'package:fit_food/Screens/Home/expert_healthcard_details.dart';
import 'package:fit_food/Screens/Home/user_details.dart';
import 'package:fit_food/Screens/Home/user_healthcard_detail.dart';
import '../../Constants/export.dart';
import '../../Models/banner_model.dart';
import '../../Models/clients_model.dart';
import '../../Models/expert_model.dart';
import 'package:badges/badges.dart' as badges;
import '../Progress/all_experts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final c = Get.put(GetController());
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              children: [
                buildAddrProfileBar(size),
                buildSearchBar(),
                const SizedBox(height: defaultPadding),
                c.role.value == 'Trainer'
                    ? buildTrainerCard(size)
                    : buildHealthCard(size),
                buildDivider("Featured Diet"),
                buildFeaturedDiet(size),
                const SizedBox(height: defaultPadding),
                buildBanner(size),
                const SizedBox(height: defaultPadding),
                c.role.value == 'User'
                    ? buildExperts(size)
                    : buildClients(size),
                const SizedBox(height: defaultPadding),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAddrProfileBar(Size size) {
    return Obx(
      () => SizedBox(
        width: size.width,
        height: size.height * 0.06,
        child: Row(
          children: [
            const Icon(Icons.my_location, color: primaryColor),
            const SizedBox(width: defaultMargin),
            Expanded(
              child: Obx(
                () => Text(
                  c.currLocation.value,
                  style: Style.normalLightTextStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
            badges.Badge(
              badgeStyle: const badges.BadgeStyle(
                badgeColor: primaryColor,
              ),
              showBadge: c.notiCount.value == 0 ? false : true,
              badgeContent: c.notiCount.value > 9
                  ? Text(
                      '9+',
                      style: Style.smallWtextStyle,
                    )
                  : Text(
                      c.notiCount.value.toString(),
                      style: Style.smallWtextStyle,
                    ),
              child: InkWell(
                onTap: () {
                  Get.to(() => NotificationScreen());
                  c.isNotiTapped.value = true;
                },
                child: const Icon(Icons.notifications,
                    color: primaryColor, size: 30),
              ),
            ),
            const SizedBox(width: defaultMargin),
          ],
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return TextFormField(
      onTap: () => Get.to(() => const SearchResult()),
      readOnly: true,
      decoration: const InputDecoration(
        constraints:
            BoxConstraints.tightFor(width: double.infinity, height: 50),
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
          borderRadius: BorderRadius.all(
            Radius.circular(12.00),
          ),
        ),
        prefixIcon: Icon(Icons.search),
        hintText: "Search ",
      ),
    );
  }

  Widget buildHealthCard(Size size) {
    return Obx(
      () => InkWell(
        onTap: () => Get.to(() => UserHealthDetail()),
        child: Container(
          height: size.height * 0.22,
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultCardRadius),
            color: Colors.black,
            image: const DecorationImage(
                image: AssetImage(cardBg), fit: BoxFit.cover, opacity: 0.8),
          ),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      c.userDP.value == ''
                          ? const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(profileImg),
                            )
                          : CircleAvatar(
                              radius: 53,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                  '$imgPath/${c.userDP.value}',
                                ),
                              ),
                            ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 135,
                        child: Text(
                          c.name.value,
                          style: Style.normalWTextStyle,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        c.phone.value,
                        style: Style.normalWTextStyle,
                      ),
                      c.isSubscribed.value
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.workspace_premium,
                                    color: whiteColor),
                                const SizedBox(width: 8),
                                Text(
                                  '${c.planName.value} Plan',
                                  style: Style.normalWTextStyle,
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                  const VerticalDivider(
                    width: 30.0,
                    thickness: 1.0,
                    color: whiteColor,
                    indent: 35,
                    endIndent: 35,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('BMI : ${c.bmi.value.toString().substring(0, 5)}',
                          style: Style.normalWTextStyle),
                      Text('Height : ${c.height.value} feet',
                          style: Style.normalWTextStyle),
                      Text('Weight : ${c.weight.value} kg',
                          style: Style.normalWTextStyle),
                      Text('Goal : ${c.goal.value}',
                          style: Style.normalWTextStyle),
                      SizedBox(
                        width: 170,
                        child: Text(
                          'Pref : ${c.pref.value}',
                          style: Style.normalWTextStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: -20,
                child: Image.asset(
                  logoWhite,
                  height: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTrainerCard(Size size) {
    return Obx(
      () => InkWell(
        onTap: () => Get.to(() => ExpertCardDetail()),
        child: Container(
          height: size.height / 4,
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultCardRadius),
            color: Colors.black,
            image: const DecorationImage(
                image: AssetImage(cardBg), fit: BoxFit.cover, opacity: 0.8),
          ),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      c.trainerDP.value == ''
                          ? const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(profileImg),
                            )
                          : CircleAvatar(
                              radius: 53,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                  '$imgPath/${c.trainerDP.value}',
                                ),
                              ),
                            ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 135,
                        child: Text(
                          c.tName.value,
                          style: Style.normalWTextStyle,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        c.tPhone.value,
                        style: Style.normalWTextStyle,
                      ),
                      SizedBox(
                        width: 140,
                        child: Text(
                          c.tMail.value,
                          style: Style.normalWTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const VerticalDivider(
                    width: 30.0,
                    thickness: 1.0,
                    color: whiteColor,
                    indent: 35,
                    endIndent: 35,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Specialist : ${c.tSpecialist.value}',
                            style: Style.normalWTextStyle),
                        Text('Experience : ${c.tExp.value} years',
                            style: Style.normalWTextStyle),
                        Text('City : ${c.tCity.value} ',
                            style: Style.normalWTextStyle),
                        Text('Gender : ${c.tGender.value}',
                            style: Style.normalWTextStyle),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: -20,
                child: Image.asset(
                  logoWhite,
                  height: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFeaturedDiet(Size size) {
    return Obx(() => buildFeaturedDietCard(size));
  }

  Widget buildFeaturedDietCard(Size size) {
    if (homeController.isLoading.value) {
      return loadShimmer(size);
    }

    final categories = homeController.foodCategories.value?.data;
    if (categories == null || categories.isEmpty) {
      return const Center(child: Text('No categories available'));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => Column(
        children: [
          Ink(
            height: size.height / 15,
            width: size.width / 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [Colors.tealAccent, Colors.teal],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(2, 2),
                ),
              ],
              border: Border.all(color: Colors.teal.shade700, width: 1),
            ),
            child: InkWell(
              onTap: () {
                Get.to(() => FoodCatLists(
                      image: '$imgPath/${categories[index].image}',
                      name: categories[index].name ?? '',
                      subCatId: categories[index].id?.toInt() ?? 0,
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: '$imgPath/${categories[index].image}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 70,
            height: 20,
            child: Text(
              categories[index].name ?? '',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.teal.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              color: Colors.black12,
              thickness: 1,
            ),
          ),
          const SizedBox(width: 5),
          Text(text, style: Style.normalTextStyle),
          const Expanded(
            child: Divider(
              color: Colors.black12,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFoodCardBanner(Size size, String image, String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: RoundedContainer(
        padding: const EdgeInsets.only(bottom: defaultPadding),
        height: size.height / 4.5,
        width: size.width,
        image: image,
        color: Colors.black,
        opacity: 0.6,
        onTap: () {},
        isImage: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: Style.xLargeWhiteTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBanner(Size size) {
    final homeController = Get.find<HomeController>();

    return Obx(() {
      if (homeController.isLoading.value) {
        return Shimmer.fromColors(
          highlightColor: highlightColor,
          baseColor: baseColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Container(
              height: size.height / 4,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultCardRadius),
                color: Colors.white,
              ),
            ),
          ),
        );
      }

      final banners = homeController.banners.value?.data;
      if (banners == null || banners.isEmpty) {
        return const Center(child: Text('No Banners'));
      }

      return CarouselSlider.builder(
        itemCount: banners.length,
        itemBuilder: (BuildContext context, int index, int realIndex) =>
            Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Container(
            height: size.height / 4,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultCardRadius),
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage('$imgPath/${banners[index].image}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        options: CarouselOptions(
          autoPlay: true,
          viewportFraction: 1,
        ),
      );
    });
  }

  loadShimmer(Size size) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 8,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 5,
      ),
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(defaultCardRadius),
              child: Container(
                height: size.height / 16,
                margin: const EdgeInsets.all(defaultMargin),
                decoration: const BoxDecoration(color: primaryColor),
              ),
            ),
            Container(
              color: primaryColor,
              height: 5,
              width: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildClients(Size size) {
    final homeController = Get.find<HomeController>();

    return Obx(() {
      if (homeController.isLoading.value) {
        return loading;
      }

      final clients = homeController.clients.value?.data;
      if (clients == null || clients.isEmpty) {
        return const Center(child: Text('No Clients found'));
      }

      return buildClientCard(size, clients);
    });
  }

  Widget buildClientCard(Size size, List clients) {
    return SizedBox(
      height: size.height * 0.27,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Clients',
                    style: Style.normalTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: clients.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () =>
                        Get.to(() => UserDetails(client: clients[index])),
                    child: RoundedContainer(
                      borderColor: Colors.black12,
                      color: whiteColor,
                      height: size.height / 4,
                      width: size.width / 2.5,
                      padding: const EdgeInsets.all(defaultPadding),
                      isImage: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          clients[index].adminId!.image == null
                              ? const CircleAvatar(
                                  radius: 50,
                                  backgroundColor: greyColor,
                                  backgroundImage: AssetImage(profileImg),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundColor: greyColor,
                                  backgroundImage: CachedNetworkImageProvider(
                                    '$imgPath/${clients[index].adminId!.image}',
                                  ),
                                ),
                          const Spacer(),
                          Text(clients[index].adminId!.name ?? '',
                              style: Style.smalltextStyle,
                              textAlign: TextAlign.center),
                          Text(clients[index].adminId!.email ?? '',
                              style: Style.smallLighttextStyle,
                              textAlign: TextAlign.center),
                          const Spacer(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.location_city,
                                  color: primaryColor),
                              const Spacer(flex: 1),
                              Text(clients[index].adminId!.city ?? '',
                                  style: Style.smallLighttextStyle),
                              const Spacer(flex: 5),
                              Text('India', style: Style.smallLighttextStyle),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildExperts(Size size) {
  final homeController = Get.find<HomeController>();

  return Obx(() {
    if (homeController.isLoading.value) {
      return loading;
    }

    final experts = homeController.experts.value?.data;
    if (experts == null || experts.isEmpty) {
      return const Center(child: Text('No experts available'));
    }

    return buildExpertCard(size, experts);
  });
}

Widget buildExpertCard(Size size, List experts) {
  final c = Get.find<GetController>();

  return SizedBox(
    height: size.height * 0.27,
    child: Column(
      children: [
        buildTitle('Our Experts'),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: experts.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {
                  c.isshowMore.value = false;
                  Get.to(() => ExpertDetails(expertData: experts[index]));
                },
                child: RoundedContainer(
                  borderColor: Colors.black12,
                  color: whiteColor,
                  height: size.height / 4,
                  width: size.width / 2.5,
                  padding: const EdgeInsets.all(defaultPadding),
                  isImage: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      experts[index].image == null
                          ? const CircleAvatar(
                              radius: 50,
                              backgroundColor: greyColor,
                              backgroundImage: AssetImage(profileImg),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundColor: greyColor,
                              backgroundImage: CachedNetworkImageProvider(
                                '$imgPath/${experts[index].image}',
                              ),
                            ),
                      const Spacer(),
                      Text(experts[index].name ?? '',
                          style: Style.smalltextStyle,
                          textAlign: TextAlign.center),
                      Text(experts[index].specialist ?? '',
                          style: Style.smallLighttextStyle,
                          textAlign: TextAlign.center),
                      const Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.location_city, color: primaryColor),
                          const Spacer(flex: 1),
                          Text(experts[index].city ?? '',
                              style: Style.smallLighttextStyle),
                          const Spacer(flex: 5),
                          Text('India', style: Style.smallLighttextStyle),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildTitle(String title) {
  final homeController = Get.find<HomeController>();

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Style.normalTextStyle,
        ),
        GestureDetector(
          onTap: () {
            final experts = homeController.experts.value;
            if (experts != null) {
              Get.to(() => AllExperts(experts: experts));
            }
          },
          child: Text(
            'View All',
            style: Style.smallLighttextStyle,
          ),
        ),
      ],
    ),
  );
}

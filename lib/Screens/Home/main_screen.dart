// ignore_for_file: deprecated_member_use
import 'package:fit_food/Screens/Cart/cart_screen.dart';
import '../../Constants/export.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List screens = [
    HomeScreen(),
    OrderScreen(),
    ProgressScreen(),
    const ProfileScreen(),
  ];
  final int selectedIndex = 0;
  final controller = Get.put(GetController());
  final List navBarItem = [];
  final c = Get.put(GetController());

  @override
  void initState() {
    super.initState();
    c.name.value = GlobalVariable.name;
    c.planName.value = GlobalVariable.planName;
    c.isSubscribed.value = GlobalVariable.isSubs;
    c.weight.value = GlobalVariable.weight;
    c.height.value = GlobalVariable.height;
    c.dob.value = GlobalVariable.dob;
    c.gender.value = GlobalVariable.gender;
    c.pref.value = GlobalVariable.pref;
    c.goal.value = GlobalVariable.goal;
    c.mail.value = GlobalVariable.email;
    c.phone.value = GlobalVariable.phone;
    c.city.value = GlobalVariable.city;
    c.role.value = GlobalVariable.role;
    c.userDP.value = GlobalVariable.userDP;
    ProfileUtils().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    ProfileUtils()
        .getbmi(double.parse(c.height.value), double.parse(c.weight.value));
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currIndex.value,
          children: [
            HomeScreen(),
            OrderScreen(),
            ProgressScreen(),
            Cart(),
            const ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          elevation: 1,
          currentIndex: controller.currIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: controller.isDarkTheme.value
              ? Style.smallColortextStyle
              : Style.smallColortextStyle,
          onTap: (index) => controller.currIndex.value = index,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
                color:
                    controller.currIndex.value == 0 ? primaryColor : greyColor,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.menu_book,
                size: 30,
                color:
                    controller.currIndex.value == 1 ? primaryColor : greyColor,
              ),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.update,
                size: 30,
                color:
                    controller.currIndex.value == 2 ? primaryColor : greyColor,
              ),
              label: 'Progress',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.local_mall_outlined,
                size: 30,
                color:
                    controller.currIndex.value == 3 ? primaryColor : greyColor,
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
                color:
                    controller.currIndex.value == 4 ? primaryColor : greyColor,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

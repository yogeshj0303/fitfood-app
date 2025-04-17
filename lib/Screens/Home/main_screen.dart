// ignore_for_file: deprecated_member_use
import 'package:fit_food/Components/cart_controller.dart';
import 'package:fit_food/Screens/Cart/cart_screen.dart';
import '../../Constants/export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final controller = Get.find<GetController>();
  final cartController = Get.find<CartController>();

  final List<Widget> _pages = [
    HomeScreen(),
    OrderScreen(),
    ProgressScreen(),
    Cart(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _initializeUserData();
    _initializeCart();
  }

  void _initializeUserData() {
    controller.name.value = GlobalVariable.name;
    controller.planName.value = GlobalVariable.planName;
    controller.isSubscribed.value = GlobalVariable.isSubs;
    controller.weight.value = GlobalVariable.weight;
    controller.height.value = GlobalVariable.height;
    controller.dob.value = GlobalVariable.dob;
    controller.gender.value = GlobalVariable.gender;
    controller.pref.value = GlobalVariable.pref;
    controller.goal.value = GlobalVariable.goal;
    controller.mail.value = GlobalVariable.email;
    controller.phone.value = GlobalVariable.phone;
    controller.city.value = GlobalVariable.city;
    controller.role.value = GlobalVariable.role;
    controller.userDP.value = GlobalVariable.userDP;
    ProfileUtils().getProfile();
  }

  Future<void> _initializeCart() async {
    try {
      if (controller.role.value == 'Trainer') {
        await cartController.showTrainersCart();
      } else {
        await cartController.showCart();
      }
    } catch (e) {
      print('Error initializing cart: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller.height.value.isNotEmpty &&
        controller.weight.value.isNotEmpty) {
      try {
        ProfileUtils().getbmi(double.parse(controller.height.value),
            double.parse(controller.weight.value));
      } catch (e) {
        print('Error calculating BMI: $e');
      }
    }

    return Scaffold(
      body: Obx(() => _pages[controller.currIndex.value]),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Obx(
      () => BottomNavigationBar(
        elevation: 1,
        currentIndex: controller.currIndex.value,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: Style.smallColortextStyle,
        onTap: (index) {
          controller.currIndex.value = index;
          // Refresh cart when navigating to cart tab
          if (index == 3) {
            _initializeCart();
          }
        },
        items: [
          _buildNavItem(Icons.home, 'Home', 0),
          _buildNavItem(Icons.menu_book, 'Orders', 1),
          _buildNavItem(Icons.update, 'Progress', 2),
          _buildNavItem(Icons.local_mall_outlined, 'Cart', 3),
          _buildNavItem(Icons.person, 'Profile', 4),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        size: 30,
        color: controller.currIndex.value == index ? primaryColor : greyColor,
      ),
      label: label,
    );
  }
}

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(GetController(), permanent: true);
    Get.put(CartController(), permanent: true);
  }
}

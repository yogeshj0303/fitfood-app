import 'package:fit_food/Screens/Cart/cart_screen.dart';
import '../../Constants/export.dart';

class TrainerMainScreen extends StatefulWidget {
  const TrainerMainScreen({super.key});

  @override
  State<TrainerMainScreen> createState() => _TrainerMainScreenState();
}

class _TrainerMainScreenState extends State<TrainerMainScreen> {
  final List navBarItem = [];
  final c = Get.put(GetController());
  final controller = Get.put(GetController());
  @override
  void initState() {
    super.initState();
    c.tName.value = GlobalVariable.trainerName;
    c.tMail.value = GlobalVariable.trainerMail;
    c.tPhone.value = GlobalVariable.trainerPhone;
    c.tSpecialist.value = GlobalVariable.trainerSpecialist;
    c.tExp.value = GlobalVariable.trainerExp;
    c.tCity.value = GlobalVariable.trainerCity;
    c.tGender.value = GlobalVariable.trainerGender;
    c.tAbout.value = GlobalVariable.trainerAbout;
    c.role.value = GlobalVariable.role;
    c.trainerDP.value = GlobalVariable.trainerdp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: c.currIndex.value,
          children: [
            HomeScreen(),
            OrderScreen(),
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
                Icons.local_mall_outlined,
                size: 30,
                color:
                    controller.currIndex.value == 2 ? primaryColor : greyColor,
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
                color:
                    controller.currIndex.value == 3 ? primaryColor : greyColor,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

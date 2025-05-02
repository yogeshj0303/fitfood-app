import 'package:fit_food/Constants/export.dart';

class GetController extends GetxController {
  //Bottom Nav Bar Index
  var currIndex = 0.obs;
  //Login with OTP
  var isAuthLoading = false.obs;
  var otp = 0000.obs;
  //Register
  var isRegLoading = false.obs;
  var isTrainRegLoading = false.obs;
  //Diet Prefernce + Goal
  var prefButtonSelIndex = 0.obs;
  var goalButtonSelIndex = 0.obs;
  //Register User Data
  var name = ''.obs;
  var mail = ''.obs;
  var city = ''.obs;
  var password = ''.obs;
  var phone = ''.obs;
  var weight = ''.obs;
  var height = ''.obs;
  var gender = ''.obs;
  var userDP = ''.obs;
  var dob = ''.obs;
  var pref = ''.obs;
  var goal = ''.obs;
  var bmi = 0.0.obs;
  var isUnderWt = false.obs;
  var isNormal = false.obs;
  //trainer
  var tName = ''.obs;
  var tMail = ''.obs;
  var tCity = ''.obs;
  var tPhone = ''.obs;
  var tSpecialist = ''.obs;
  var tExp = ''.obs;
  var tGender = ''.obs;
  var tAbout = ''.obs;
  var role = ''.obs;
  var trainerDP = ''.obs;
  var isDpLoading = false.obs;
  //faqs
  var isFaqTapped = false.obs;
  var faqSelectedIndex = 0.obs;
  //location
  var currLocation = ''.obs;
  //autoLogin phone
  var autologinId = 0.obs;
  var autoLoginPhone = ''.obs;
  var autoRole = ''.obs;
  //trainer autologin
  var autoEmail = ''.obs;
  var autoPass = ''.obs;
  //save profile loading
  var isEditLoading = false.obs;
  //notification count
  var notiCount = 0.obs;
  var prevnotiCount = 0.obs;
  var isNotiTapped = false.obs;
  //expert details
  var isshowMore = false.obs;
  var isConsultLoad = false.obs;
  //edit weight
  var isEditWeight = false.obs;
  //Theme
  var isDarkTheme = false.obs;
//plan
  var isSubscribed = false.obs;
  var subsId = 0.obs;
  var planId = 0.obs;
  var planName = 'No Plan'.obs;

  @override
  void onInit() {
    super.onInit();
    loadThemeState();
  }

  Future<void> loadThemeState() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkTheme.value = prefs.getBool('isDarkMode') ?? false;
    updateTheme();
  }

  void updateTheme() {
    Get.changeTheme(isDarkTheme.value ? ThemeData.dark() : ThemeData.light());
  }
  //gvdlighdorigh

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkTheme.value = !isDarkTheme.value;
    await prefs.setBool('isDarkMode', isDarkTheme.value);
    updateTheme();
  }
}

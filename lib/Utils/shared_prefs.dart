import 'package:fit_food/Constants/export.dart';

class SharedPrefs {
  final c = Get.put(GetController());

  Future<void> loginSave(String phone, int id, String role) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('phone', phone);
    preferences.setInt('id', id);
    preferences.setString('role', role);
  }

  Future<void> trainerLoginSave(String email, String pass, String role) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', email);
    preferences.setString('pass', pass);
    preferences.setString('role', role);
  }

  Future<bool> autoLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('phone')) {
      String phone = preferences.getString('phone')!;
      int id = preferences.getInt('id')!;
      String role = preferences.getString('role')!;
      c.autoLoginPhone.value = phone;
      c.autologinId.value = id;
      c.autoRole.value = role;
      return true;
    }
    if (preferences.containsKey('email')) {
      String email = preferences.getString('email')!;
      String pass = preferences.getString('pass')!;
      String role = preferences.getString('role')!;
      c.autoEmail.value = email;
      c.autoPass.value = pass;
      c.autoRole.value = role;
      return true;
    }
    return false;
  }

  Future<void> loginClear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    c.isSubscribed.value = false;
    c.currIndex.value = 0;
    c.notiCount.value = 0;
    Get.offAll(() => const LoginScreen());
  }

  Future<void> saveNotiCount(int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('count', count);
  }

  Future getNotiCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('count')) {
      int count = prefs.getInt('count')!;
      c.prevnotiCount.value = count;
    } else {
      c.prevnotiCount.value = 0;
    }
  }
}

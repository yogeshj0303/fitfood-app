import 'dart:convert';
import 'dart:async';
import 'package:fit_food/Constants/export.dart';
import 'package:fit_food/Screens/AuthScreen/Login/trainer_login.dart';
import 'package:fit_food/Screens/Home/trainer_main_screen.dart';
import 'package:fit_food/Services/location_services.dart';
import 'package:http/http.dart' as http;

class AuthUtils {
  final c = Get.put(GetController());
  Timer? _debounce;

  Future<T> _debounceRequest<T>(Future<T> Function() requestFunction) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    final completer = Completer<T>();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        final result = await requestFunction();
        completer.complete(result);
      } catch (e) {
        completer.completeError(e);
      }
    });
    return completer.future;
  }

  Future<void> sendOtp(String phone) async {
    return _debounceRequest(() async {
      c.isAuthLoading.value = true;
      final url = '${apiUrl}sendotp?phone=$phone';
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body.toString());
        if (data['error'] == false) {
          c.otp.value = data['otp'];
          c.isAuthLoading.value = false;
          Get.to(() => OtpScreen(number: phone));
        } else {
          c.isAuthLoading.value = false;
          Fluttertoast.showToast(msg: 'Please Enter your mobile number');
        }
      } else {
        c.isAuthLoading.value = false;
        Fluttertoast.showToast(msg: 'Internal Server Error');
      }
    });
  }

  Future<void> getRegistered(
      {required String name,
      required String phone,
      required String height,
      required String password,
      required String weight,
      required String gender,
      required String city,
      required String email,
      required String pref,
      required String goal,
      required String dob}) async {
    final url =
        '${apiUrl}signup?name=$name&phone=$phone&height=$height&password=$password&weight=$weight&gender=$gender&city=$city&email=$email&preference=$pref&goal=$goal&dob=$dob';
    c.isRegLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        LocationServices.getLocation();
        GlobalVariable.id = data['data']['id'];
        GlobalVariable.name = data['data']['name'];
        GlobalVariable.phone = data['data']['phone'];
        GlobalVariable.weight = data['data']['weight'];
        GlobalVariable.height = data['data']['height'];
        GlobalVariable.gender = data['data']['gender'];
        GlobalVariable.email = data['data']['email'];
        GlobalVariable.dob = data['data']['dob'];
        GlobalVariable.city = data['data']['city'];
        GlobalVariable.pref = data['data']['preference'];
        GlobalVariable.goal = data['data']['goal'];
        GlobalVariable.userDP = '';
        GlobalVariable.role = 'User';
        SharedPrefs().loginSave(phone, GlobalVariable.id!, 'User');
        Get.offAll(() => const MainScreen());
        c.isRegLoading.value = false;
      } else {
        Fluttertoast.showToast(msg: data['message']);
        c.isRegLoading.value = false;
      }
    } else {
      Fluttertoast.showToast(msg: 'Internal Server Error');
      c.isRegLoading.value = false;
    }
  }

  Future<void> authCheck(String phone) async {
    return _debounceRequest(() async {
      c.isRegLoading.value = true;
      final url = '${apiUrl}logincheck?phone=$phone';
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        LocationServices.getLocation();
        GlobalVariable.id = data['data']['id'];
        GlobalVariable.name = data['data']['name'];
        GlobalVariable.phone = data['data']['phone'];
        GlobalVariable.weight = data['data']['weight'];
        GlobalVariable.height = data['data']['height'];
        GlobalVariable.gender = data['data']['gender'];
        GlobalVariable.email = data['data']['email'];
        GlobalVariable.dob = data['data']['dob'];
        GlobalVariable.city = data['data']['city'];
        GlobalVariable.pref = data['data']['preference'];
        GlobalVariable.goal = data['data']['goal'];
        GlobalVariable.userDP = data['data']['image'] ?? '';
        GlobalVariable.role = 'User';
        SharedPrefs().loginSave(phone, GlobalVariable.id!, 'User');
        c.isRegLoading.value = false;
        Get.offAll(() => const MainScreen());
      } else {
        c.isRegLoading.value = false;
        Get.off(() => const UserData());
      }
    } else {
      Fluttertoast.showToast(msg: 'Internal Server Error');
        c.isRegLoading.value = false;
      }
    });
  }

  Future<void> trainerLogin(String email, String pass) async {
    return _debounceRequest(() async {
      final url = '${apiUrl}trainerLogin?email=$email&password=$pass';
      c.isTrainRegLoading.value = true;
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        GlobalVariable.trainersID = data['result']['id'];
        GlobalVariable.trainerName = data['result']['name'];
        GlobalVariable.trainerMail = data['result']['email'];
        GlobalVariable.trainerPhone = data['result']['phone'];
        GlobalVariable.trainerSpecialist = data['result']['specialist'];
        GlobalVariable.trainerCity = data['result']['city'];
        GlobalVariable.trainerExp = data['result']['experience'];
        GlobalVariable.trainerGender = data['result']['gender'];
        GlobalVariable.trainerAbout = data['result']['about'];
        GlobalVariable.trainerdp = data['result']['image'] ?? '';
        GlobalVariable.role = 'Trainer';
        SharedPrefs().trainerLoginSave(email, pass, 'Trainer');
        Get.offAll(() => const TrainerMainScreen());
        c.isTrainRegLoading.value = false;
      } else {
        c.isTrainRegLoading.value = false;
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      c.isTrainRegLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
      }
    });
  }

  Future<void> trainerRegister(
      {required String name,
      required String email,
      required String pass,
      required String gender,
      required String city,
      required String specialist,
      required String exp,
      required String about,
      required String mobile}) async {
    final url =
        '${apiUrl}trainerRegister?name=$name&email=$email&gender=$gender&city=$city&password=$pass&specialist=$specialist&experience=$exp&phone=$mobile&about=$about';
    return _debounceRequest(() async {
      c.isTrainRegLoading.value = true; 
      final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        Get.off(() => TrainerLogin());
        c.isTrainRegLoading.value = false;
        Fluttertoast.showToast(msg: 'Registration succesful');
      } else {
        c.isTrainRegLoading.value = false;
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      c.isTrainRegLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
      }
    });
  }
}

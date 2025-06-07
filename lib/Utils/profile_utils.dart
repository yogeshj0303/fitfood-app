import 'dart:convert';
import 'package:fit_food/Models/aboutus_model.dart';
import 'package:fit_food/Models/consulted_model.dart';
import 'package:fit_food/Models/faq_model.dart';
import '../Constants/export.dart';
import '../Models/subs_model.dart';
import 'package:http/http.dart' as http;
import '../Screens/Progress/graph_controller.dart';
import 'dart:async';

class ProfileUtils {
  final c = Get.put(GetController());
  final c1 = Get.put(GraphController());
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

  getbmi(double height, double weight) {
    // Convert height from feet to meters
    height = height * 0.3048;
    c.bmi.value = weight / (height * height);
    c.isUnderWt.value = c.bmi.value < 18.5;
    c.isNormal.value = c.bmi.value >= 18.5 && c.bmi.value <= 25.5;
  }

  Future<SubsModel> getSubscriptions() async {
    return _debounceRequest(() async {
      const url = '${apiUrl}plan';
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body.toString());
        if (data['error'] == false) {
          return SubsModel.fromJson(data);
        } else {
          Fluttertoast.showToast(msg: 'Something went wrong');
        }
      }
      throw Exception('Unable to load data');
    });
  }

  Future purchasePlan(int subsId, int planId) async {
    return _debounceRequest(() async {
      final url =
          'https://Fitness.stilld.in/api/purchase?admin_id=${GlobalVariable.id}&subscribe_id=$subsId&plan_id=$planId';
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        c.isSubscribed.value = true;
        c.planName.value = data['data']['plan_name'].toString();
        Get.defaultDialog(
          title: 'Congratulation!!!',
          middleText: 'Plan purchased successfully',
          onConfirm: () => Get.back(),
          confirmTextColor: whiteColor,
          textConfirm: 'OK',
        );
      } else {
        Fluttertoast.showToast(msg: data['data']);
      }
    } else {
        Fluttertoast.showToast(msg: 'Internal server error');
      }
    });
  }

  Future<FaqModel> getFaqs() async {
    return _debounceRequest(() async {
      const url = '${apiUrl}faq';
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        return FaqModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
      }
      throw Exception('Unable to load data');
    });
  }

  Future<AboutUsModel> aboutUs() async {
    return _debounceRequest(() async {
      const url = '${apiUrl}aboutus';
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        return AboutUsModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
      }
      throw Exception('Unable to load data');
    });
  }

  Future postReview(String rating, String review, int expertId) async {
    return _debounceRequest(() async {
      final url =
          '${apiUrl}rating?rating=$rating&review=$review&admin_id=${GlobalVariable.id}&expert_id=$expertId';
      final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        Fluttertoast.showToast(
            msg: 'Thank you for submitting your feedback...');
        Get.back();
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
        Get.back();
      }
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong');
      Get.back();
    }
    });
  }

  Future<void> addWeightForBmi(String wt) async {
    return _debounceRequest(() async {
      final url = '${apiUrl}changebmi?user_id=${GlobalVariable.id}&weight=$wt';
      final res = await http.post(Uri.parse(url));
      if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      if (data['error'] == false) {
        Fluttertoast.showToast(msg: 'updated');
        c.weight.value = data['data']['weight'];
        c1.getUserBmiData();
        c.currIndex.value = 2;
        Get.offAll(() => const MainScreen());
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
        Get.back();
      }
    } else {
      Fluttertoast.showToast(msg: '${res.statusCode} ${res.reasonPhrase}');
      Get.back();
    }
    });
  }

  Future<void> getProfile() async {
    return _debounceRequest(() async {
      final url = '${apiUrl}Profile?user_id=${GlobalVariable.id}';
      final res = await http.post(Uri.parse(url));
      if (res.statusCode == 200) {
      final data = jsonDecode(res.body.toString());
      if (data['error'] == false) {
        c.userDP.value = data['data']['image'] ?? '';
        c.planName.value = data['data']['subs_name'] == null
            ? 'Not Subscribed'
            : data['data']['subs_name']['plan_name'];
        c.isSubscribed.value = data['data']['subs_status'] == 1
            ? true
            : data['data']['subs_status'] == null
                ? false
                : false;
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(msg: '${res.statusCode} ${res.reasonPhrase}');
    }
    });
  }

  Future<ConsultedModel> getConsultedHistory() async {
    return _debounceRequest(() async {
      final url = '${apiUrl}consultList?user_id=${GlobalVariable.id}';
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        return ConsultedModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
      }
      throw Exception('Unable to load data');
    });
  }

  Future<void> editProfile({
    required String name,
    required String phone,
    required String height,
    required String weight,
    required String email,
    required String gender,
    required String city,
    required String dob,
    required String pref,
    required String goal,
  }) async {
    return _debounceRequest(() async {
      final url =
          '${apiUrl}UpdateProfile?admin_id=${GlobalVariable.id}&name=$name&phone=$phone&height=$height&weight=$weight&email=$email&gender=$gender&city=$city&dob=$dob&preference=$pref&goal=$goal';
      c.isEditLoading.value = true;
    final res = await http.post(Uri.parse(url));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body.toString());
      if (data['error'] == false) {
        c.mail.value = data['data']['email'];
        c.city.value = data['data']['city'];
        c.gender.value = data['data']['gender'];
        c.dob.value = data['data']['dob'];
        c.height.value = data['data']['height'];
        c.weight.value = data['data']['weight'];
        c.pref.value = data['data']['preference'];
        c.goal.value = data['data']['goal'];
        c.isEditLoading.value = false;
        Get.back();
        Fluttertoast.showToast(msg: 'Profile updated successfully').then(
          (value) => ProfileUtils().getbmi(
            double.parse(c.height.value),
            double.parse(c.weight.value),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
        c.isEditLoading.value = false;
      }
    } else {
      Fluttertoast.showToast(msg: '${res.statusCode} ${res.reasonPhrase}');
      c.isEditLoading.value = false;
    }
    });
  }

  Future<void> editTrainerProfile({
    required String exp,
    required String specialist,
    required String city,
    required String about,
  }) async {
    final url =
        '${apiUrl}updateProfile?trainer_id=${GlobalVariable.trainersID}&city=$city&experience=$exp&specialist=$specialist&about=$about';
    c.isEditLoading.value = true;
    final res = await http.post(Uri.parse(url));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body.toString());
      if (data['error'] == false) {
        c.tCity.value = city;
        c.tSpecialist.value = specialist;
        c.tExp.value = exp;
        c.tAbout.value = about;
        c.isEditLoading.value = false;
        Get.back();
        Fluttertoast.showToast(msg: 'Profile updated successfully');
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
        c.isEditLoading.value = false;
      }
    } else {
      Fluttertoast.showToast(msg: 'Internal Server Error');
      c.isEditLoading.value = false;
    }
  }

  Future<void> updateTrainerDP({required String imagePath}) async {
    final url =
        '${apiUrl}updateTrainerImage?trainer_id=${GlobalVariable.trainersID}';
    c.isDpLoading.value = true;
    final request = http.MultipartRequest('Post', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseCode = await response.stream.bytesToString();
      final data = jsonDecode(responseCode);
      if (data['error'] == false) {
        trainerProfile();
        c.isDpLoading.value = false;
        Fluttertoast.showToast(msg: 'Image uploaded');
      } else {
        c.isDpLoading.value = false;
        Fluttertoast.showToast(msg: 'Error true');
      }
    } else {
      c.isDpLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<void> updateUserDP({required String imagePath}) async {
    final url = '${apiUrl}updateUserImage?user_id=${GlobalVariable.id}';
    c.isDpLoading.value = true;
    final request = http.MultipartRequest('Post', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseCode = await response.stream.bytesToString();
      final data = jsonDecode(responseCode);
      if (data['error'] == false) {
        getProfile();
        c.isDpLoading.value = false;
        Fluttertoast.showToast(msg: 'Image uploaded');
      } else {
        c.isDpLoading.value = false;
        Fluttertoast.showToast(msg: 'Error true');
      }
    } else {
      c.isDpLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<void> trainerProfile() async {
    return _debounceRequest(() async {
      final url =
          '${apiUrl}showTrainerProfile?trainer_id=${GlobalVariable.trainersID}';
      final res = await http.post(Uri.parse(url));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body.toString());
      if (data['error'] == false) {
        c.trainerDP.value = data['data']['image'];
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(msg: '${res.statusCode} ${res.reasonPhrase}');
    }
    });
  }
}

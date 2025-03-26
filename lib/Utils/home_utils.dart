import 'dart:async';
import 'dart:convert';
import '../Constants/export.dart';
import 'package:http/http.dart' as http;
import '../Models/banner_model.dart';
import '../Models/clients_model.dart';
import '../Models/expert_model.dart';
import '../Models/foodsubcat_model.dart';
import '../Models/noti_model.dart';

class HomeUtils {
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

  Future<FoodCategoryModel?> getFoodCategries() async {
    return _debounceRequest(() async {
      const url = '${apiUrl}category';
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body.toString());
        return FoodCategoryModel.fromJson(data);
      }
      throw Exception('Unable to load data');
    });
  }

  Future<FoodSubCategoryModel> getFoodSubCategries(int catId) async {
    return _debounceRequest(() async {
      final url = '${apiUrl}Subcategorie?category_id=$catId';
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body.toString());
        return FoodSubCategoryModel.fromJson(data);
      }
      throw Exception('Unable to load data');
    });
  }

  Future<BannerModel> getBanner() async {
    return _debounceRequest(() async {
      const url = '${apiUrl}banners';
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body.toString());
      return BannerModel.fromJson(data);
      }
      throw Exception('Unable to load data');
    });
  }

  Future<ExpertModel> getExperts() async {
    return _debounceRequest(() async {
      const url = '${apiUrl}expert';
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body.toString());
        return ExpertModel.fromJson(data);
      }
      throw Exception('Unable to load data');
    });
  }

  Future<ClientsModel> getClients() async {
    final url = '${apiUrl}appointment?expert_id=${GlobalVariable.trainersID}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      return ClientsModel.fromJson(data);
    }
    throw Exception('Unable to load data');
  }

  Future<void> getExpertConsult(int expertId) async {
    return _debounceRequest(() async {
      final url =
          '${apiUrl}consult?admin_id=${GlobalVariable.id}&expert_id=$expertId';
      c.isConsultLoad.value = true;
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        Fluttertoast.showToast(
            msg: 'Request successful! Our team will call you soon');
        c.isConsultLoad.value = false;
      } else {
        Fluttertoast.showToast(msg: data['data']);
          c.isConsultLoad.value = false;
        }
      } else {
        Fluttertoast.showToast(
            msg: '${response.statusCode} ${response.reasonPhrase}');
        c.isConsultLoad.value = false;
      }
    });
  }

  Future<FoodSubCategoryModel> getSearch(String query) async {
    return _debounceRequest(() async {
      final url = '${apiUrl}searchbycat?name=$query';
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        return FoodSubCategoryModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
        }
      }
      throw Exception('Unable to load data');
    });
  }

  Future<NotificationModel> getNotification() async {
    return _debounceRequest(() async {
      final url = '${apiUrl}getnotifications?admin_id=${GlobalVariable.id}';

    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        return NotificationModel.fromJson(data);
      }
      }
      throw Exception('Unable to load data');
    });
  }

  Future<NotificationModel> getTrainerNotification() async {
    return _debounceRequest(() async {
      final url = '${apiUrl}notifications?expert_id=${GlobalVariable.trainersID}';
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data['error'] == false) {
        return NotificationModel.fromJson(data);
      }
      }
      throw Exception('Unable to load data');
    });
  }

  Future streamNotification(int userId) async {
    return _debounceRequest(() async {
      final url = '${apiUrl}getnotifications?admin_id=$userId';
      String title = '';
      String body = '';
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      int totalnotiCount = NotificationModel.fromJson(data).message!.length;
      if (data['error'] == false && totalnotiCount != 0) {
        final item = NotificationModel.fromJson(data).message![0];
        title = item.type!;
        body = item.message!;
        if (c.prevnotiCount.value < totalnotiCount) {
          c.notiCount.value = totalnotiCount - c.prevnotiCount.value;
          NotificationService().showNotification(title: title, body: body);
          c.prevnotiCount.value = totalnotiCount;
          SharedPrefs().saveNotiCount(c.prevnotiCount.value);
        }
        if (c.isNotiTapped.value) {
          c.notiCount.value = 0;
          c.isNotiTapped.value = false;
        }
      }
      }
    });
  }
}

import 'dart:convert';
import 'package:fit_food/Constants/export.dart';
import 'package:http/http.dart' as http;

class GraphController extends GetxController {
  RxList<UserGraphData> userBmiData = <UserGraphData>[].obs;

  Future<void> getUserBmiData() async {
    final url = '${apiUrl}showUser?user_id=${GlobalVariable.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        List<UserGraphData> allData = (data['data'] as List)
            .map((e) => UserGraphData(
                date: e['date'].toString().split(' ').first +
                    e['date'].toString().split(' ')[1].substring(0, 3) +
                    e['date'].toString().split(' ').last.substring(2, 4),
                bmi: double.parse(e['bmi']),
                height: double.parse(e['height']),
                weight: double.parse(e['weight'])))
            .toList();
        userBmiData.value = allData;
      } else {
        Fluttertoast.showToast(msg: 'error true');
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }
}

class UserGraphData {
  UserGraphData(
      {required this.date,
      required this.bmi,
      required this.height,
      required this.weight});
  final String date;
  final double bmi;
  final double height;
  final double weight;
}

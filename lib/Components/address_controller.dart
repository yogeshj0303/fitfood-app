import 'dart:convert';
import 'package:fit_food/Constants/export.dart';
import 'package:http/http.dart' as http;

class AddressController extends GetxController {
  RxList<AddressModel> addressList = <AddressModel>[].obs;
  RxInt defaultAddressId = 0.obs;
  Future<void> showAddresses() async {
    final url = '${apiUrl}showAddress?user_id=${GlobalVariable.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        List<AddressModel> allData = (data['data'] as List)
            .map((data) => AddressModel(
                id: data['id'],
                address: data['address_1'],
                locality: data['locality'],
                city: data['city'],
                state: data['state'],
                pincode: data['pin_code']))
            .toList();
        addressList.value = allData;
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.reasonPhrase} ${response.statusCode}');
    }
  }

  Future<void> addAddress(
      {required String address,
      required String locality,
      required String city,
      required String state,
      required String pincode}) async {
    final url =
        '${apiUrl}addAddress?user_id=${GlobalVariable.id}&locality=$locality&city=$city&state=$state&address_1=$address&pin_code=$pincode';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        Fluttertoast.showToast(msg: 'Added');
        addressList.add(AddressModel(
            id: data['data']['id'],
            address: address,
            locality: locality,
            city: city,
            state: state,
            pincode: pincode));
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.reasonPhrase} ${response.statusCode}');
    }
  }

  Future<void> deleteAddress({required int addressId}) async {
    final url =
        '${apiUrl}delete?address_id=$addressId&user_id=${GlobalVariable.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        Fluttertoast.showToast(msg: 'Deleted');
        addressList.removeWhere((address) => address.id == addressId);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.reasonPhrase} ${response.statusCode}');
    }
  }

  Future<void> showTrainerAddresses() async {
    final url =
        '${apiUrl}showTraineraddress?trainer_id=${GlobalVariable.trainersID}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        List<AddressModel> allData = (data['data'] as List)
            .map((data) => AddressModel(
                id: data['id'],
                address: data['address_1'],
                locality: data['locality'],
                city: data['city'],
                state: data['state'],
                pincode: data['pin_code']))
            .toList();
        addressList.value = allData;
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.reasonPhrase} ${response.statusCode}');
    }
  }

  Future<void> addTrainerAddress(
      {required String address,
      required String locality,
      required String city,
      required String state,
      required String pincode}) async {
    final url =
        '${apiUrl}trainerAddress?trainer_id=${GlobalVariable.trainersID}&city=$city&state=$state&pin_code=$pincode&address_1=$address&locality=$locality';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        Fluttertoast.showToast(msg: 'Added');
        addressList.add(AddressModel(
            id: data['data']['id'],
            address: address,
            locality: locality,
            city: city,
            state: state,
            pincode: pincode));
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.reasonPhrase} ${response.statusCode}');
    }
  }

  Future<void> deleteTrainerAddress({required int addressId}) async {
    final url =
        '${apiUrl}deleteTraineraddress?trainer_id=${GlobalVariable.trainersID}&address_id=$addressId}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        Fluttertoast.showToast(msg: 'Deleted');
        addressList.removeWhere((address) => address.id == addressId);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.reasonPhrase} ${response.statusCode}');
    }
  }
}

class AddressModel {
  final int id;
  final String address;
  final String locality;
  final String city;
  final String state;
  final String pincode;

  AddressModel(
      {required this.id,
      required this.address,
      required this.locality,
      required this.city,
      required this.state,
      required this.pincode});
}

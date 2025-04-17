import 'package:fit_food/Constants/export.dart';

import '../../Models/banner_model.dart';
import '../../Models/clients_model.dart';
import '../../Models/expert_model.dart';
import '../../Models/food_category_model.dart';

class HomeController extends GetxController {
  final foodCategories = Rx<FoodCategoryModel?>(null);
  final banners = Rx<BannerModel?>(null);
  final experts = Rx<ExpertModel?>(null);
  final clients = Rx<ClientsModel?>(null);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    isLoading.value = true;
    try {
      await Future.wait([
        fetchFoodCategories(),
        fetchBanners(),
        fetchExperts(),
        fetchClients(),
      ]);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFoodCategories() async {
    try {
      foodCategories.value = await HomeUtils().getFoodCategries();
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  Future<void> fetchBanners() async {
    try {
      banners.value = await HomeUtils().getBanner();
    } catch (e) {
      print('Error fetching banners: $e');
    }
  }

  Future<void> fetchExperts() async {
    try {
      experts.value = await HomeUtils().getExperts();
    } catch (e) {
      print('Error fetching experts: $e');
    }
  }

  Future<void> fetchClients() async {
    try {
      clients.value = await HomeUtils().getClients();
    } catch (e) {
      print('Error fetching clients: $e');
    }
  }
}

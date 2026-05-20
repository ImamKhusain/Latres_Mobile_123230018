import 'package:get/get.dart';
import '../service/api_service.dart';

class HomeController extends GetxController {
  final ApiService _apiService = ApiService();

  RxList shows = [].obs;
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();

    getAllShows();
  }

  Future<void> getAllShows() async {
    try {
      isLoading.value = true;

      errorMessage.value = '';

      final result = await _apiService.fetchShows();

      shows.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshShows() async {
    await getAllShows();
  }
}
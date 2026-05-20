import 'package:get/get.dart';

import '../service/api_service.dart';

class DetailController extends GetxController {
  final ApiService _apiService = ApiService();

  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;
  RxMap<String, dynamic> detailShow = <String, dynamic>{}.obs;

  int? showId;

  @override
  void onInit() {
    super.onInit();
    _getArgumentAndLoadData();
  }

  void _getArgumentAndLoadData() {
    final args = Get.arguments;

    if (args is int) {
      showId = args;
      loadDetail(args);
    } else {
      errorMessage.value = 'ID show tidak valid';
      isLoading.value = false;
    }
  }

  Future<void> loadDetail(int id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _apiService.fetchShowById(id);
      detailShow.assignAll(Map<String, dynamic>.from(result));
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  String stripHtmlTags(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>'), '');
  }
}
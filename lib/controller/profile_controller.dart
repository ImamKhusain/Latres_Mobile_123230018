import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/app_routes.dart';

class ProfileController extends GetxController {
  RxString username = "Guest".obs;

  static const String loginKey =
      "login";

  static const String usernameKey =
      "username";

  @override
  void onInit() {
    super.onInit();

    getUsername();
  }

  Future<void> getUsername() async {
    try {
      final prefs =
          await SharedPreferences
              .getInstance();

      final savedUsername =
          prefs.getString(
                usernameKey,
              ) ??
              "Guest";

      username.value =
          savedUsername;
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal mengambil data user",
        snackPosition:
            SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> logout() async {
    try {
      final prefs =
          await SharedPreferences
              .getInstance();

      await prefs.remove(
        loginKey,
      );

      await prefs.remove(
        usernameKey,
      );

      Get.offAllNamed(
        AppRoutes.login,
      );

      Get.snackbar(
        "Berhasil",
        "Logout berhasil",
        snackPosition:
            SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Logout gagal",
        snackPosition:
            SnackPosition.BOTTOM,
      );
    }
  }
}
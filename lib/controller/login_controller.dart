import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;
  RxBool obscurePassword = true.obs;

  static const String loginKey = "login";
  static const String usernameKey = "username";

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();

    final isLogin = prefs.getBool(loginKey) ?? false;

    if (isLogin) {
      Get.offAllNamed(AppRoutes.home);
    }
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      await Future.delayed(
        const Duration(milliseconds: 800),
      );

      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool(loginKey, true);

      await prefs.setString(
        usernameKey,
        usernameController.text.trim(),
      );

      Get.offAllNamed(AppRoutes.home);
      Get.snackbar(
        "Berhasil",
        "Login berhasil",
        snackPosition: SnackPosition.TOP,
        backgroundColor:
          const Color(
        0xFF16A34A,
      ),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 12,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 12,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();

    super.onClose();
  }
}
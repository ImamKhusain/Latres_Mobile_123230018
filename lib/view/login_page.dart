import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(
                maxWidth: 420,
              ),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF171717),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    const Icon(
                      Icons.movie,
                      color: Colors.red,
                      size: 70,
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "NontonSkuy",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Login untuk melanjutkan",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 30),

                    TextFormField(
                      controller:
                          controller.usernameController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: inputDecoration(
                        hint: "Username",
                        icon: Icons.person,
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty) {
                          return "Username wajib diisi";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    Obx(
                      () => TextFormField(
                        controller:
                            controller.passwordController,
                        obscureText:
                            controller.obscurePassword.value,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: inputDecoration(
                          hint: "Password",
                          icon: Icons.lock,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller
                                      .obscurePassword
                                      .value =
                                  !controller
                                      .obscurePassword
                                      .value;
                            },
                            icon: Icon(
                              controller
                                      .obscurePassword
                                      .value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return "Password wajib diisi";
                          }

                          return null;
                        },
                      ),
                    ),

                    const SizedBox(height: 30),

                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed:
                              controller.isLoading.value
                                  ? null
                                  : controller.login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                14,
                              ),
                            ),
                          ),
                          child:
                              controller.isLoading.value
                                  ? const CircularProgressIndicator(
                                      color:
                                          Colors.white,
                                    )
                                  : const Text(
                                      "Login",
                                    ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.white54,
      ),
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFF262626),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
    );
  }
}
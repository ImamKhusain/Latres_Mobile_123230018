import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() =>
      _ProfilePageState();
}

class _ProfilePageState
    extends State<ProfilePage> {
  String username = '';

  static const String loginKey =
      "login";

  static const String usernameKey =
      "username";

  @override
  void initState() {
    super.initState();

    getUsername();
  }

  Future<void> getUsername() async {
    final prefs =
        await SharedPreferences.getInstance();

    setState(() {
      username =
          prefs.getString(usernameKey) ??
              "Guest";
    });
  }

  Future<void> logout() async {
    final prefs =
        await SharedPreferences.getInstance();
    await prefs.remove(loginKey);
    await prefs.remove(usernameKey);

    Get.offAllNamed(
      AppRoutes.login,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          20,
        ),

        child: Column(
          children: [
            const CircleAvatar(
              radius: 55,
              backgroundColor:
                  Colors.red,
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              username,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(
                18,
              ),

              decoration: BoxDecoration(
                color: const Color(
                  0xFF1A1A1A,
                ),

                borderRadius:
                    BorderRadius.circular(
                  18,
                ),
              ),

              child: const Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [
                  Text(
                    "Kesan",
                    style: TextStyle(
                      color:
                          Colors.white,
                      fontSize: 18,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Praktikum mobile sangat seru dan membantu memahami pengembangan aplikasi Flutter secara langsung mulai dari UI, API, state management, hingga local database.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      height: 1.7,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Pesan",
                    style: TextStyle(
                      color:
                          Colors.white,
                      fontSize: 18,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Terima kasih untuk seluruh asisten praktikum yang sudah membimbing selama praktikum berlangsung, dan minta tolong soal responsi nanti jangan terlalu sulit mas. Semoga ilmunya bermanfaat dan sukses selalu.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      height: 1.7,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton.icon(
                onPressed: logout,

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.red,
                  foregroundColor:
                      Colors.white,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius
                            .circular(
                      14,
                    ),
                  ),
                ),

                icon: const Icon(
                  Icons.logout,
                ),

                label: const Text(
                  "Logout",
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar:
          BottomNavigationBar(
        backgroundColor:
            const Color(0xFF121212),

        selectedItemColor:
            Colors.red,

        unselectedItemColor:
            Colors.white70,

        currentIndex: 2,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],

        onTap: (index) {
          if (index == 0) {
            Get.offAllNamed(
              AppRoutes.home,
            );
          }

          if (index == 1) {
            Get.offAllNamed(
              AppRoutes.favorite,
            );
          }
        },
      ),
    );
  }
}
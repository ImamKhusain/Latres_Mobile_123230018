import 'package:get/get.dart';

import '../view/detail_page.dart';
import '../view/favorite_page.dart';
import '../view/home_page.dart';
import '../view/login_page.dart';
import '../view/profile_page.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    // LOGIN
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
    ),

    // HOME
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
    ),

    // DETAIL
    GetPage(
      name: AppRoutes.detail,
      page: () => const DetailPage(),
    ),

    // FAVORITE
    GetPage(
      name: AppRoutes.favorite,
      page: () => const FavoritePage(),
    ),

    // PROFILE
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
    ),
  ];
}
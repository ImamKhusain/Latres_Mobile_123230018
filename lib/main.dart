import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'controller/favorite_controller.dart';
import 'model/favorite.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // INIT HIVE
  await Hive.initFlutter();

  // REGISTER ADAPTER
  Hive.registerAdapter(
    FavoriteAdapter(),
  );

  // OPEN BOX
  await Hive.openBox<Favorite>(
    'favorites',
  );

  // REGISTER CONTROLLER
  Get.put(
    FavoriteController(),
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner:
          false,

      title: "NontonSkuy",

      initialRoute:
          AppRoutes.login,

      getPages:
          AppPages.pages,
    );
  }
}
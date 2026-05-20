import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../model/favorite.dart';

class FavoriteController extends GetxController {
  late Box<Favorite> favoriteBox;

  RxList<Favorite> favoriteList =
      <Favorite>[].obs;

  @override
  void onInit() {
    super.onInit();

    favoriteBox =
        Hive.box<Favorite>('favorites');

    loadFavorites();
  }

  // LOAD ALL FAVORITES
  void loadFavorites() {
    favoriteList.assignAll(
      favoriteBox.values.toList(),
    );
  }

  // CHECK FAVORITE
  bool isFavorite(int id) {
    return favoriteBox.containsKey(id);
  }

  // ADD FAVORITE
  Future<void> addFavorite({
    required int id,
    required String title,
    required String imageUrl,
    required double rating,
  }) async {
    // CHECK DUPLICATE
    if (isFavorite(id)) {
      Get.snackbar(
        "Info",
        "Show sudah ada di favorit",

        snackPosition:
            SnackPosition.TOP,

        backgroundColor:
            Colors.orange,

        colorText: Colors.white,

        margin:
            const EdgeInsets.all(
          12,
        ),

        borderRadius: 12,

        duration: const Duration(
          seconds: 2,
        ),
      );

      return;
    }

    final favorite = Favorite(
      id: id,
      title: title,
      imageUrl: imageUrl,
      rating: rating,
    );

    // SAVE TO HIVE
    await favoriteBox.put(
      id,
      favorite,
    );

    loadFavorites();

    // SUCCESS NOTIFICATION
    Get.snackbar(
      "Berhasil",
      "Berhasil ditambahkan ke favorit",

      snackPosition:
          SnackPosition.TOP,

      backgroundColor:
          const Color(
        0xFF16A34A,
      ),

      colorText: Colors.white,

      margin:
          const EdgeInsets.all(
        12,
      ),

      borderRadius: 12,

      duration: const Duration(
        seconds: 2,
      ),
    );
  }

  // REMOVE FAVORITE
  Future<void> removeFavorite(
    int id,
  ) async {
    await favoriteBox.delete(id);

    loadFavorites();

    Get.snackbar(
      "Berhasil",
      "Berhasil dihapus dari favorit",

      snackPosition:
          SnackPosition.TOP,

      backgroundColor:
          Colors.red,

      colorText: Colors.white,

      margin:
          const EdgeInsets.all(
        12,
      ),

      borderRadius: 12,

      duration: const Duration(
        seconds: 2,
      ),
    );
  }
}
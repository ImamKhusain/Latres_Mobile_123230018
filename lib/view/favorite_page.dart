import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/favorite_controller.dart';
import '../routes/app_routes.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      FavoriteController(),
    );

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Favorite Shows",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Obx(() {
        if (controller.favoriteList.isEmpty) {
          return const Center(
            child: Text(
              "Belum ada favorite",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount:
              controller.favoriteList.length,
          itemBuilder: (context, index) {
            final favorite =
                controller.favoriteList[index];

            return GestureDetector(
              onTap: () {
                Get.toNamed(
                  AppRoutes.detail,
                  arguments: favorite.id,
                );
              },

              child: Container(
                margin:
                    const EdgeInsets.only(
                  bottom: 14,
                ),

                decoration: BoxDecoration(
                  color: const Color(
                    0xFF1A1A1A,
                  ),
                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                ),

                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.only(
                        topLeft:
                            Radius.circular(
                          16,
                        ),
                        bottomLeft:
                            Radius.circular(
                          16,
                        ),
                      ),

                      child: Image.network(
                        favorite.imageUrl,
                        width: 100,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.all(
                          12,
                        ),

                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [
                            Text(
                              favorite.title,
                              maxLines: 2,
                              overflow:
                                  TextOverflow
                                      .ellipsis,
                              style:
                                  const TextStyle(
                                color:
                                    Colors.white,
                                fontSize: 16,
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color:
                                      Colors.amber,
                                  size: 18,
                                ),

                                const SizedBox(
                                  width: 4,
                                ),

                                Text(
                                  favorite.rating
                                      .toString(),
                                  style:
                                      const TextStyle(
                                    color: Colors
                                        .white70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        controller
                            .removeFavorite(
                          favorite.id,
                        );
                      },

                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),

      bottomNavigationBar:
          BottomNavigationBar(
        backgroundColor:
            const Color(0xFF121212),
        selectedItemColor: Colors.red,
        unselectedItemColor:
            Colors.white70,
        currentIndex: 1,

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

          if (index == 2) {
            Get.offAllNamed(
              AppRoutes.profile,
            );
          }
        },
      ),
    );
  }
}
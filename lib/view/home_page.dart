import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';
import '../routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      HomeController(),
    );

    return Scaffold(
      backgroundColor: Colors.black,

      // APPBAR
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "TV Shows",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // BODY
      body: Obx(
        () {
          // LOADING
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }

          // ERROR
          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  controller.errorMessage.value,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          // DATA EMPTY
          if (controller.shows.isEmpty) {
            return const Center(
              child: Text(
                "Data show kosong",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          // SUCCESS
          return RefreshIndicator(
            onRefresh: controller.refreshShows,
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.shows.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.62,
              ),
              itemBuilder: (context, index) {
                final show =
                    controller.shows[index];
                final image =
                    show['image']?['medium'];
                final title =
                    show['name'] ?? '-';
                final rating =
                    show['rating']?['average'];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.detail,
                      arguments: show['id'],
                    );
                  },

                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFF1A1A1A,
                      ),
                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                    ),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.only(
                              topLeft:
                                  Radius.circular(
                                18,
                              ),
                              topRight:
                                  Radius.circular(
                                18,
                              ),
                            ),
                            child: image != null
                                ? Image.network(
                                    image,
                                    width:
                                        double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    color:
                                        Colors.grey,
                                    child:
                                        const Center(
                                      child: Icon(
                                        Icons
                                            .broken_image,
                                        color: Colors
                                            .white,
                                      ),
                                    ),
                                  ),
                          ),
                        ),

                        Padding(
                          padding:
                              const EdgeInsets.all(
                            10,
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              Text(
                                title,
                                maxLines: 1,
                                overflow:
                                    TextOverflow
                                        .ellipsis,
                                style:
                                    const TextStyle(
                                  color:
                                      Colors.white,
                                  fontSize: 15,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),

                              const SizedBox(
                                height: 6,
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
                                    rating != null
                                        ? rating
                                            .toString()
                                        : 'N/A',
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
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(
          0xFF121212,
        ),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white70,
        currentIndex: 0,

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
          if (index == 1) {
            Get.toNamed('/favorite');
          }

          if (index == 2) {
            Get.toNamed('/profile');
          }
        },
      ),
    );
  }
}